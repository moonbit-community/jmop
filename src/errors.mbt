///|
pub suberror EvalError {
  EvalError(Error_)
}

///|
pub suberror RangeError {
  RangeError(Error_)
}

///|
pub suberror TypeError {
  TypeError(Error_)
}

///|
pub suberror ReferenceError {
  ReferenceError(Error_)
}

///|
pub suberror SyntaxError {
  SyntaxError(Error_)
}

///|
pub suberror URIError {
  URIError(Error_)
}

///|
pub suberror AggregateError {
  AggregateError(Error_)
}

///|
pub suberror InternalError {
  InternalError(Error_)
}

///|
pub(all) suberror InvalidCast {
  InvalidCast((SourceLoc, Value, String?))
}

///|
pub(all) suberror InvalidField {
  InvalidField((SourceLoc, Value, String))
}

///|
// pub suberror RuntimeError Value

///|
pub suberror UnwrapNull {
  UnwrapNull(SourceLoc)
}

///|
pub suberror UnwrapUndefined {
  UnwrapUndefined(SourceLoc)
}

///|
pub suberror InvalidNestedPromise {
  InvalidNestedPromise(SourceLoc)
}

///|
pub impl Show for EvalError with output(self, buf) {
  self.as_error().output(buf)
}

///|
pub impl Show for RangeError with output(self, buf) {
  self.as_error().output(buf)
}

///|
pub impl Show for TypeError with output(self, buf) {
  self.as_error().output(buf)
}

///|
pub impl Show for ReferenceError with output(self, buf) {
  self.as_error().output(buf)
}

///|
pub impl Show for SyntaxError with output(self, buf) {
  self.as_error().output(buf)
}

///|
pub impl Show for URIError with output(self, buf) {
  self.as_error().output(buf)
}

///|
pub impl Show for AggregateError with output(self, buf) {
  self.as_error().output(buf)
}

///|
pub impl Show for InternalError with output(self, buf) {
  self.as_error().output(buf)
}

///|
pub impl Show for InvalidNestedPromise with output(self, buf) {
  let InvalidNestedPromise(loc) = self
  print_error(
    buf,
    Some(loc),
    err="InvalidNestedPromise",
    msg="type `Promise[Promise[T]]` is not allowed. See Promise documentation in MDN.",
  )
}

///|
pub impl Show for UnwrapUndefined with output(self, buf) {
  let UnwrapUndefined(loc) = self
  print_error(
    buf,
    Some(loc),
    err="UnwrapUndefined",
    msg="cannot unwrap undefined",
  )
}

///|
pub impl Show for InvalidCast with output(self, buf) {
  let InvalidCast((loc, value, target)) = self
  print_error(
    buf,
    Some(loc),
    err="InvalidCast",
    msg="cannot cast `\{value}` to `\{target}`",
  )
}

///|
pub impl Show for InvalidField with output(self, buf) {
  let InvalidField((loc, value, field)) = self
  print_error(
    buf,
    Some(loc),
    err="FieldNotFound",
    msg="'\{field}' is undefined or null in \{value}",
  )
}

///|
priv struct Loc {
  file : String
  start : (Int, Int)
  end : (Int, Int)
}

///|
fn parse_loc(loc : SourceLoc) -> Loc {
  let s = loc.to_string()
  match s.split(":").collect() {
    [file, line1, m, col2] if m.split("-").collect() is [col1, line2] => {
      let line1 = @strconv.parse_int(line1) catch { StrConvError(_) => 0 }
      let col1 = @strconv.parse_int(col1) catch { StrConvError(_) => 0 }
      let line2 = @strconv.parse_int(line2) catch { StrConvError(_) => 0 }
      let col2 = @strconv.parse_int(col2) catch { StrConvError(_) => 0 }
      { file: file.to_string(), start: (line1, col1), end: (line2, col2) }
    }
    _ => { file: "", start: (0, 0), end: (0, 0) }
  }
}

///|
fn print_error(
  buf : &Logger,
  loc : SourceLoc?,
  err~ : String,
  msg~ : String,
) -> Unit {
  match loc {
    None =>
      buf
      ..write_string("Error (@jmop.")
      ..write_string(err)
      ..write_string("): ")
      ..write_string(msg)
    Some(loc) => {
      let loc = parse_loc(loc)
      ignore(loc.start)
      buf
      ..write_string("Error (@jmop.")
      ..write_string(err)
      ..write_string(") at \"")
      ..write_string("\{loc.file}:\{loc.end.0}:\{loc.end.1-1}")
      ..write_string("\": ")
      ..write_string(msg)
    }
  }
}

///|
/// for internal use only
pub fn[T] convert_error(loc : SourceLoc, f : () -> T) -> T raise {
  catch_error(f, e => {
    e.set_source_loc(loc)
    match e.get_name() {
      "EvalError" => raise EvalError(e)
      "RangeError" => raise RangeError(e)
      "TypeError" => raise TypeError(e)
      "ReferenceError" => raise ReferenceError(e)
      "SyntaxError" => raise SyntaxError(e)
      "URIError" => raise URIError(e)
      "AggregateError" => raise AggregateError(e)
      "InternalError" => raise InternalError(e)
      _ => panic()
    }
  })
}

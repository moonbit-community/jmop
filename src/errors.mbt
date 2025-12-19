///|
pub suberror EvalError Error_

///|
pub suberror RangeError Error_

///|
pub suberror TypeError Error_

///|
pub suberror ReferenceError Error_

///|
pub suberror SyntaxError Error_

///|
pub suberror URIError Error_

///|
pub suberror AggregateError Error_

///|
pub suberror InternalError Error_

///|
pub(all) suberror InvalidCast (SourceLoc, Value, String?)

///|
pub(all) suberror InvalidField (SourceLoc, Value, String)

///|
// pub suberror RuntimeError Value

///|
pub suberror UnwrapNull SourceLoc

///|
pub suberror UnwrapUndefined SourceLoc

///|
pub suberror InvalidNestedPromise SourceLoc

///|

///|
pub impl IsValue for EvalError

///|
pub impl IsObject for EvalError

///|
pub impl IsError for EvalError

///|

///|
pub impl IsValue for RangeError

///|
pub impl IsObject for RangeError

///|
pub impl IsError for RangeError

///|

///|
pub impl IsValue for TypeError

///|
pub impl IsObject for TypeError

///|
pub impl IsError for TypeError

///|

///|
pub impl IsValue for ReferenceError

///|
pub impl IsObject for ReferenceError

///|
pub impl IsError for ReferenceError

///|

///|
pub impl IsValue for SyntaxError

///|
pub impl IsObject for SyntaxError

///|
pub impl IsError for SyntaxError

///|

///|
pub impl IsValue for TypeError

///|
pub impl IsObject for TypeError

///|
pub impl IsError for TypeError

///|

///|
pub impl IsValue for URIError

///|
pub impl IsObject for URIError

///|
pub impl IsError for URIError

///|

///|
pub impl IsValue for AggregateError

///|
pub impl IsObject for AggregateError

///|
pub impl IsError for AggregateError

///|

///|
pub impl IsValue for InternalError

///|
pub impl IsObject for InternalError

///|
pub impl IsError for InternalError

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

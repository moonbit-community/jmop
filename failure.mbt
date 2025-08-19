///|
pub suberror TypeError (SourceLoc, JsTypeError)

///|
pub suberror InvalidCast (SourceLoc, Value, String)

///|
pub(all) suberror InvalidField (SourceLoc, Value, String)

///|
pub suberror RuntimeError Value

///|
pub suberror UnwrapNull SourceLoc

///|
pub suberror UnwrapUndefined SourceLoc

///|
pub suberror InvalidNestedPromise SourceLoc

///|
pub impl Show for InvalidNestedPromise with output(self, buf) {
  let InvalidNestedPromise(loc) = self
  print_error(
    buf,
    loc,
    err="InvalidNestedPromise",
    msg="type `Promise[Promise[T]]` is not allowed. See Promise documentation in MDN.",
  )
}

///|
pub impl Show for UnwrapUndefined with output(self, buf) {
  let UnwrapUndefined(loc) = self
  print_error(buf, loc, err="UnwrapUndefined", msg="cannot unwrap undefined")
}

///|
pub impl Show for InvalidCast with output(self, buf) {
  let InvalidCast((loc, value, target)) = self
  print_error(
    buf,
    loc,
    err="InvalidCast",
    msg="cannot cast `\{value}` to `\{target}`",
  )
}

///|
pub impl Show for InvalidField with output(self, buf) {
  let InvalidField((loc, value, field)) = self
  print_error(
    buf,
    loc,
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
  loc : SourceLoc,
  err~ : String,
  msg~ : String,
) -> Unit {
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

///|
fn[T, E] Result::failwith(self : Result[T, E], f : (E) -> T raise?) -> T raise? {
  match self {
    Err(e) => f(e)
    Ok(v) => v
  }
}

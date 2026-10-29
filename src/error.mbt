///|
/// Represents a JavaScript Error object.
struct Error_(Object)

///|
pub fn Error_::new(message : String, cause? : Value) -> Error_ {
  ffi_error_new(message, Optional::from_option(cause))
}

///|
pub fn Error_::new_with_loc(message : String, loc : SourceLoc) -> Error_ {
  let e = ffi_error_new(message, Optional::undefined())
  e.set_source_loc(loc)
  e
}

///|
pub trait IsError: IsObject {
  fn as_error(Self) -> Error_ = _
  fn get_name(Self) -> String = _
  fn get_message(Self) -> String = _
  fn get_cause(Self) -> Optional[Value] = _
  fn get_source_loc(Self) -> SourceLoc? = _
  fn set_source_loc(Self, SourceLoc) -> Unit = _
}

///|
pub impl DynCast for Error_ with fn from_value(v) {
  if v.instance_of("Error") {
    v.to_object()
  } else {
    fail_cast(target="Error")
  }
}

///|
impl IsError with fn as_error(self) {
  identity(self)
}

///|
impl IsError with fn get_name(self) {
  ffi_error_get_name(self.as_error())
}

///|
impl IsError with fn get_message(self) {
  ffi_error_get_message(self.as_error())
}

///|
impl IsError with fn get_cause(self) {
  ffi_error_get_cause(self.as_error())
}

///|
impl IsError with fn get_source_loc(self) {
  ffi_error_get_source_loc(self.as_error()).to_option()
}

///|
impl IsError with fn set_source_loc(self, loc) {
  ffi_error_set_source_loc(self.as_error(), loc)
}

///|
pub impl Show for Error_ with fn output(self, buf) {
  print_error(
    buf,
    self.get_source_loc(),
    err=self.get_name(),
    msg=self.get_message(),
  )
}

///|
pub fn[T] catch_error(f : () -> T, on_error : (Error_) -> T raise?) -> T raise? {
  let r = ffi_run_with_error(identity(f))
  match any_to_option(identity(r)) {
    None => identity(r)
    Some(e) => on_error(e)
  }
}

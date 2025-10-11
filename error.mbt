///|
/// Represents a JavaScript Error object.
struct Error_(Object)

///|
pub fn Error_::new(message : String, cause? : Any) -> Error_ {
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
  as_error(Self) -> Error_ = _
  get_name(Self) -> String = _
  get_message(Self) -> String = _
  get_cause(Self) -> Any = _
  get_source_loc(Self) -> SourceLoc? = _
  set_source_loc(Self, SourceLoc) -> Unit = _
}

///|
pub impl IsAny for Error_

///|
pub impl IsValue for Error_

///|
pub impl IsObject for Error_

///|
pub impl IsError for Error_

///|
pub impl DynCast for Error_ with from_value(v) {
  if v.instance_of("Error") {
    v.to_object()
  } else {
    fail_cast(target="Error")
  }
}

///|
impl IsError with as_error(self) {
  identity(self)
}

///|
impl IsError with get_name(self) {
  ffi_error_get_name(self.as_error())
}

///|
impl IsError with get_message(self) {
  ffi_error_get_message(self.as_error())
}

///|
impl IsError with get_cause(self) {
  ffi_error_get_cause(self.as_error())
}

///|
impl IsError with get_source_loc(self) {
  ffi_error_get_source_loc(self.as_error()).to_option()
}

///|
impl IsError with set_source_loc(self, loc) {
  ffi_error_set_source_loc(self.as_error(), loc)
}

///|
pub impl Show for Error_ with output(self, buf) {
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
  match r.as_any().to_option() {
    None => identity(r)
    Some(e) => on_error(e)
  }
}

///|
extern "js" fn ffi_run_with_error(f : () -> Any) -> Any = "(f) => { try { return f(); } catch(e) { return e; } }"

///|
extern "js" fn ffi_error_get_name(x : Error_) -> String = "(x) => x.name"

///|
extern "js" fn ffi_error_get_message(x : Error_) -> String = "(x) => x.message"

///|
extern "js" fn ffi_error_get_cause(x : Error_) -> Any = "(x) => x.cause"

///|
extern "js" fn ffi_error_get_source_loc(x : Error_) -> Nullable[SourceLoc] = "(x) => x.moonbit_source_loc"

///|
extern "js" fn ffi_error_set_source_loc(x : Error_, loc : SourceLoc) -> Unit = "(x, loc) => { x.moonbit_source_loc = loc; }"

///|
extern "js" fn ffi_error_new(message : String, cause : Optional[Any]) -> Error_ = "(message, cause) => new Error(message, { cause: cause })"

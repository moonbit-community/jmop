///|
/// A `Value` can be undefined.
/// 
/// This value is not boxed, which means `Optional::some(Optional::undefined())` 
/// is the same as `Optional::undefined()`.
type Optional[T]

///|
#callsite(autofill(loc))
pub fn[T] Optional::unwrap(
  self : Self[T],
  loc~ : SourceLoc,
) -> T raise UnwrapUndefined {
  if ffi_is_undefined(identity(self)) {
    raise UnwrapUndefined(loc)
  } else {
    identity(self)
  }
}

///|
#callsite(autofill(loc))
pub fn Optional::unwrap_value(
  self : Self[Nullable[Value]],
  loc~ : SourceLoc,
) -> Value raise {
  self.unwrap(loc~).unwrap(loc~)
}

///|
pub fn[T] Optional::from(x : T) -> Optional[T] {
  identity(x)
}

///|
pub fn[T] Optional::undefined() -> Optional[T] {
  identity(ffi_undefined())
}

///|
pub fn[T] Optional::to_option(self : Self[T]) -> T? {
  if ffi_is_undefined(identity(self)) {
    None
  } else {
    Some(identity(self))
  }
}

///|
pub fn[T] Optional::from_option(opt : T?) -> Self[T] {
  match opt {
    None => undefined()
    Some(x) => identity(x)
  }
}

///|
pub fnalias Optional::(from as optional, undefined)

///|
extern "js" fn ffi_is_undefined(x : Any) -> Bool = "(x) => x === undefined"

///|
extern "js" fn ffi_undefined() -> Any = "() => undefined"

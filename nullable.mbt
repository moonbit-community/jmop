///|
/// A `Value` can be null.
/// 
/// This value is not boxed, which means `Nullable::some(Nullable::null())` 
/// is the same as `Nullable::null()`.
type Nullable[T]

///|
#callsite(autofill(loc))
pub fn[T] Nullable::unwrap(
  self : Self[T],
  loc~ : SourceLoc,
) -> T raise UnwrapNull {
  if ffi_object_is_null(identity(self)) {
    raise UnwrapNull(loc)
  } else {
    identity(self)
  }
}

///|
#callsite(autofill(loc))
pub fn Nullable::unwrap_value(
  self : Self[Optional[Value]],
  loc~ : SourceLoc,
) -> Value raise {
  self.unwrap(loc~).unwrap(loc~)
}

///|
pub fn[T] Nullable::from(x : T) -> Nullable[T] {
  identity(x)
}

///|
pub fn[T] Nullable::null() -> Nullable[T] {
  identity(ffi_null())
}

///| Convert Nullable to a boxed Option
pub fn[T] Nullable::to_option(self : Self[T]) -> T? {
  if ffi_object_is_null(identity(self)) {
    Some(identity(self))
  } else {
    None
  }
}

///|
pub fnalias Nullable::(from as nullable, null)

///|
extern "js" fn ffi_object_is_null(x : Any) -> Bool = "(x) => x === null"

///|
extern "js" fn ffi_null() -> Any = "() => null"

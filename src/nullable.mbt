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
#as_free_fn(nullable)
pub fn[T] Nullable::from(x : T) -> Nullable[T] {
  identity(x)
}

///|
#as_free_fn(null)
pub fn[T] Nullable::null() -> Nullable[T] {
  identity(ffi_null())
}

///|
/// Convert Nullable to a boxed Option
pub fn[T] Nullable::to_option(self : Self[T]) -> T? {
  if ffi_object_is_null(identity(self)) {
    None
  } else {
    Some(identity(self))
  }
}

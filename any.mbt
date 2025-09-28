///|
/// Represent any value in js, including the null and undefined.
struct Any(Optional[Nullable[Value]])

///|
pub(open) trait IsAny {
  as_any(Self) -> Any = _
}

///|
impl IsAny with as_any(self) {
  self |> identity
}

///|
pub impl IsAny for Any

///|
pub impl IsAny for String

///|
pub impl IsAny for Double

///|
pub impl IsAny for Int

///|
pub impl IsAny for Bool

///|
pub impl IsAny for Unit

///|
pub impl[T : IsAny] IsAny for Array[T]

///|
pub fn[T] Any::from(x : T) -> Any {
  identity(x)
}

///|
/// Checks if the value is neither null nor undefined and returns it.
/// Otherwise, raises an `UnwrapUndefined` or `UnwrapNull` error.
#callsite(autofill(loc))
pub fn Any::unwrap(x : Self, loc~ : SourceLoc) -> Value raise {
  x.inner().unwrap_value(loc~)
}

///|
pub fn[T] Any::to_option(self : Self) -> T? {
  if ffi_is_undefined(identity(self)) || ffi_object_is_null(identity(self)) {
    None
  } else {
    Some(identity(self))
  }
}

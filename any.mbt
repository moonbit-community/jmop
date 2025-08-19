///| Represent any value in js, including the null and undefined.
struct Any(Optional[Nullable[Value]])

///|
pub fn[T] Any::from(x : T) -> Any {
  identity(x)
}

///|
/// Checks if the value is neither null nor undefined and returns it.
/// Otherwise, raises an `UnwrapUndefined` or `UnwrapNull` error.
#callsite(autofill(loc))
pub fn Any::unwrap_value(x : Self, loc~ : SourceLoc) -> Value raise {
  x.inner().unwrap_value(loc~)
}

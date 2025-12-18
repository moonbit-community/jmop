///|
/// Represent any value in js, including the null and undefined.
pub type Any = Optional[Nullable[Value]]

///|
pub(open) trait IsAny {
  as_any(Self) -> Any = _
}

///|
impl IsAny with as_any(self) {
  self |> identity
}

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
pub fn[T] any_from(x : T) -> Any {
  identity(x)
}

///|
/// Checks if the value is neither null nor undefined and returns it.
/// Otherwise, raises an `UnwrapUndefined` or `UnwrapNull` error.
#callsite(autofill(loc))
pub fn any_unwrap(x : Any, loc~ : SourceLoc) -> Value raise {
  x.unwrap_value(loc~)
}

///|
pub fn[T : DynCast] any_to_option(x : Any) -> T? {
  Some(DynCast::from_value(any_unwrap(x))) catch {
    UnwrapNull(_) | UnwrapUndefined(_) => None
    _ => None
  }
}

///|
pub(open) trait DynCast {
  as_value(Self) -> Value = _
  from_value(Value) -> DynCastResult[Self]
}

///|
impl DynCast with as_value(self) {
  identity(self)
}

///|
pub(all) struct DynCastResult[T](Result[T, InvalidCast])

///|
#callsite(autofill(loc))
fn[T] DynCastResult::rethrow(
  self : Self[T],
  loc~ : SourceLoc,
) -> T raise InvalidCast {
  match self.inner() {
    Err(InvalidCast((_, value, target))) =>
      raise InvalidCast((loc, value, target))
    Ok(x) => x
  }
}

///|
#callsite(autofill(loc))
pub fn[T : DynCast] dyn_cast(x : &IsValue, loc~ : SourceLoc) -> T raise {
  DynCast::from_value(x.as_value()).rethrow(loc~)
}

///|
pub impl DynCast for Value with from_value(value) {
  Ok(value)
}

///|
pub impl DynCast for Double with from_value(value) {
  try? value.to_number()
}

///|
pub impl DynCast for Int with from_value(value) {
  try? value.to_number().to_int()
}

///|
pub impl DynCast for Bool with from_value(value) {
  try? value.to_boolean()
}

///|
pub impl DynCast for String with from_value(value) {
  try? value.to_string()
}

///|
pub impl[T : DynCast] DynCast for Array[T] with from_value(value) {
  try? value.to_array()
}

///|
pub(open) trait DynCast {
  as_value(Self) -> Value = _
  from_value(Value) -> Self raise
}

///|
suberror DynCastFailed String?

///|
pub fn[T] fail_cast(target? : String) -> T raise DynCastFailed {
  raise DynCastFailed(target)
}

///|
impl DynCast with as_value(self) {
  identity(self)
}

///|
#callsite(autofill(loc))
pub fn[T : DynCast] dyn_cast(x : &IsValue, loc~ : SourceLoc) -> T raise {
  DynCast::from_value(x.as_value()) catch {
    DynCastFailed(target) => raise InvalidCast((loc, x.as_value(), target))
    e => raise e
  }
}

///|
pub impl DynCast for Value with from_value(value) {
  value
}

///|
pub impl DynCast for Double with from_value(value) {
  value.to_number() catch {
    InvalidCast((_, _, target)) => fail_cast(target?)
  }
}

///|
pub impl DynCast for Int with from_value(value) {
  value.to_number().to_int() catch {
    InvalidCast((_, _, target)) => fail_cast(target?)
  }
}

///|
pub impl DynCast for Bool with from_value(value) {
  value.to_boolean() catch {
    InvalidCast((_, _, target)) => fail_cast(target?)
  }
}

///|
pub impl DynCast for String with from_value(value) {
  value.to_string() catch {
    InvalidCast((_, _, target)) => fail_cast(target?)
  }
}

///|
pub impl[T : DynCast] DynCast for Array[T] with from_value(value) {
  value.to_array() catch {
    InvalidCast((_, _, target)) => fail_cast(target?)
    e => raise e
  }
}

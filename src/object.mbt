///|
/// Object represents a non-null JavaScript object.
/// 
/// Hint: if you are looking for object with null, use `Nullable[Object]`.
pub type Object

///|
pub trait IsObject: IsValue {}

///|
#callsite(autofill(loc))
pub fn Object::new(
  pairs : Map[String, &IsValue],
  loc~ : SourceLoc,
) -> Self raise {
  let self = Object::empty()
  for k, v in pairs {
    self.set(k, v, loc~)
  }
  self
}

///|
pub fn Object::empty() -> Self {
  ffi_object_new()
}

///|
pub fn Object::self(self : Self) -> Self {
  self
}

///|
pub fn Object::assign(self : Self, sources : Array[&IsObject]) -> Unit {
  ffi_object_assign(
    self.as_value(),
    FixedArray::from_array(sources.map(x => IsValue::as_value(x))),
  )
}

///|
pub fn Object::seal(self : Self) -> Unit {
  ffi_object_seal(self.as_value())
}

///|
pub fn Object::freeze(self : Self) -> Unit {
  ffi_object_freeze(self.as_value())
}

///|
pub fn Object::has_own(self : Self, prop : &IsStringOrSymbol) -> Bool {
  ffi_object_has_own(self.as_value(), IsValue::as_value(prop))
}

///|
#callsite(autofill(loc))
pub fn Object::set(
  self : Self,
  k : &IsStringOrSymbol,
  v : &IsValue,
  loc~ : SourceLoc,
) -> Unit raise {
  convert_error(loc, fn() {
    ffi_object_set(self.as_value(), IsValue::as_value(k), v.as_value())
  })
}

///|
#callsite(autofill(loc))
pub fn Object::get(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Value raise {
  ffi_object_get(self.as_value(), IsValue::as_value(prop)).unwrap_value(loc~)
}

///|
#callsite(autofill(loc))
pub fn Object::get_number(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Double raise {
  self.get(prop, loc~).to_number(loc~)
}

///|
#callsite(autofill(loc))
pub fn Object::get_object(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Object raise {
  self.get(prop, loc~).to_object(loc~)
}

///|
#callsite(autofill(loc))
pub fn Object::get_boolean(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Bool raise {
  self.get(prop, loc~).to_boolean(loc~)
}

///|
#callsite(autofill(loc))
pub fn Object::get_string(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> String raise {
  self.get(prop, loc~).to_string(loc~)
}

///|
#callsite(autofill(loc))
pub fn Object::get_symbol(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Symbol raise {
  self.get(prop, loc~).to_symbol(loc~)
}

///|
#callsite(autofill(loc))
pub fn Object::get_function(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Function raise {
  self.get(prop, loc~).to_function(loc~)
}

///|
#callsite(autofill(loc))
pub fn Object::get_bigint(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Bigint raise {
  self.get(prop, loc~).to_bigint(loc~)
}

///|
#callsite(autofill(loc))
pub fn[T : DynCast] Object::get_array(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Array[T] raise {
  self.get(prop, loc~).to_array(loc~)
}

///|
#callsite(autofill(loc))
pub fn Object::get_method(
  self : Self,
  prop : &IsStringOrSymbol,
  loc~ : SourceLoc,
) -> Function raise {
  self.get(prop).to_function(loc~).bind(self.as_value())
}

///|
#callsite(autofill(loc))
pub fn Object::call(
  self : Self,
  method_ : &IsStringOrSymbol,
  args : Array[&IsValue],
  loc~ : SourceLoc,
) -> Value raise {
  self.get(method_, loc~).to_function(loc~).apply(self.as_value(), args)
}

///|
pub fn Object::instance_of(
  self : Self,
  ctor : &IsStringOrFunctionOrObject,
) -> Bool {
  let ctor = IsValue::as_value(ctor)
  let ctor = global_this.get_function(ctor.to_string()).as_value() catch {
      InvalidCast(_) => ctor
      _ => panic()
    }
  ffi_instanceof(self.as_value(), ctor)
}

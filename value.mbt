///|
/// A value that is neither null nor undefined
pub type Value

///|
pub(open) trait IsValue {
  as_value(Self) -> Value = _
  as_any(Self) -> Any = _
}

///|
pub impl IsValue for Value

///|
pub impl IsValue for Unit

///|
pub impl IsValue for Bool

///|
pub impl IsValue for Double

///|
pub impl IsValue for Int

///|
pub impl IsValue for String

///|
pub impl[T : IsValue] IsValue for Array[T]

///|
pub impl Show for Value with output(self, buf) {
  buf.write_string(ffi_to_string(self))
}

///|
impl IsValue with as_value(self) {
  identity(self)
}

///|
impl IsValue with as_any(self) {
  identity(self)
}

///|
pub fn Value::as_any(self : Self) -> Any {
  identity(self)
}

///|
pub fn Value::as_value(self : Self) -> Value {
  identity(self)
}

///|
#callsite(autofill(loc))
pub fn Value::to_number(
  self : Self,
  loc~ : SourceLoc,
) -> Double raise InvalidCast {
  if self.get_type() == "number" {
    identity(self)
  } else {
    raise InvalidCast((loc, (self.as_value()), Some("Double")))
  }
}

///|
#callsite(autofill(loc))
pub fn Value::to_string(
  self : Self,
  loc~ : SourceLoc,
) -> String raise InvalidCast {
  if self.get_type() is "string" {
    identity(self)
  } else {
    raise InvalidCast((loc, (self.as_value()), Some("String")))
  }
}

///|
#callsite(autofill(loc))
pub fn Value::to_object(
  self : Self,
  loc~ : SourceLoc,
) -> Object raise InvalidCast {
  if self.get_type() == "object" && !ffi_object_is_null(self.as_any()) {
    identity(self)
  } else {
    raise InvalidCast((loc, (self.as_value()), Some("Object")))
  }
}

///|
#callsite(autofill(loc))
pub fn Value::to_bigint(
  self : Self,
  loc~ : SourceLoc,
) -> Bigint raise InvalidCast {
  if self.get_type() == "bigint" {
    identity(self)
  } else {
    raise InvalidCast((loc, (self.as_value()), Some("Bigint")))
  }
}

///|
#callsite(autofill(loc))
pub fn Value::to_symbol(
  self : Self,
  loc~ : SourceLoc,
) -> Symbol raise InvalidCast {
  if self.get_type() == "symbol" {
    identity(self)
  } else {
    raise InvalidCast((loc, (self.as_value()), Some("Symbol")))
  }
}

///|
#callsite(autofill(loc))
pub fn Value::to_function(
  self : Self,
  loc~ : SourceLoc,
) -> Function raise InvalidCast {
  if self.get_type() == "function" {
    identity(self)
  } else {
    raise InvalidCast((loc, (self.as_value()), Some("Function")))
  }
}

///|
#callsite(autofill(loc))
pub fn Value::to_boolean(
  self : Self,
  loc~ : SourceLoc,
) -> Bool raise InvalidCast {
  if self.get_type() == "boolean" {
    identity(self)
  } else {
    raise InvalidCast((loc, self.as_value(), Some("Bool")))
  }
}

///|
#callsite(autofill(loc))
pub fn[T : DynCast] Value::to_array(
  self : Self,
  loc~ : SourceLoc,
) -> Array[T] raise {
  if ffi_is_array(self) {
    let arr : Array[Value] = identity(self)
    arr.map(x => dyn_cast(x))
  } else {
    raise InvalidCast((loc, self.as_value(), Some("Array")))
  }
}

///|
pub fn Value::get_type(self : Self) -> String {
  ffi_typeof(self.as_any())
}

///|
pub fn Value::instance_of(self : Self, ctor : &IsFunctionOrObject) -> Bool {
  ffi_instanceof(self.as_any(), ctor.as_value())
}

///|
extern "js" fn ffi_typeof(x : Any) -> String = "(x) => typeof x"

///|
extern "js" fn ffi_instanceof(value : Any, ctor : Value) -> Bool = "(value, ctor) => value instanceof ctor"

///|
extern "js" fn ffi_to_string(x : Value) -> String = "(x) => JSON.stringify(x)"

///|
extern "js" fn ffi_is_array(x : Value) -> Bool = "(x) => Array.isArray(x)"

///|
fn[A, B] identity(a : A) -> B = "%identity"

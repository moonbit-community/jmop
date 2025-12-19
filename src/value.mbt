///|
/// A value that is neither null nor undefined
pub type Value

///|
pub(open) trait IsValue: IsAny {
  as_value(Self) -> Value = _
}

///|
pub impl Show for Value with output(self, buf) {
  buf.write_string(ffi_to_string(self))
}

///|
impl IsValue with as_value(self) {
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
    raise InvalidCast((loc, self.as_value(), Some("Double")))
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
    raise InvalidCast((loc, self.as_value(), Some("String")))
  }
}

///|
#callsite(autofill(loc))
pub fn Value::to_object(
  self : Self,
  loc~ : SourceLoc,
) -> Object raise InvalidCast {
  if self.get_type() == "object" && !ffi_object_is_null(identity(self)) {
    identity(self)
  } else {
    raise InvalidCast((loc, self.as_value(), Some("Object")))
  }
}

///|
#callsite(autofill(loc))
pub fn Value::to_error(
  self : Self,
  loc~ : SourceLoc,
) -> Error_ raise InvalidCast {
  if self.instance_of("Error") {
    identity(self)
  } else {
    raise InvalidCast((loc, self.as_value(), Some("Error")))
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
    raise InvalidCast((loc, self.as_value(), Some("Bigint")))
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
    raise InvalidCast((loc, self.as_value(), Some("Symbol")))
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
    raise InvalidCast((loc, self.as_value(), Some("Function")))
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
pub fn Value::instance_of(
  self : Self,
  ctor : &IsStringOrFunctionOrObject,
) -> Bool {
  let ctor = ctor.as_value()
  let ctor = global_this.get_function(ctor.to_string()).as_value() catch {
      InvalidCast(_) => ctor
      _ => panic()
    }
  ffi_instanceof(self, ctor)
}

///|
fn[A, B] identity(a : A) -> B = "%identity"

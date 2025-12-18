///|
test "Value::instance_of checks type" {
  let obj = @jmop.Object::empty()
  inspect(obj.as_value().instance_of("Object"), content="true")
}

///|
test "Value::to_bigint converts bigint" {
  let bigint_ctor = @jmop.global_this.get("BigInt").to_function()
  let bigint_value = bigint_ctor.call([123])
  let bigint = bigint_value.to_bigint()
  inspect(bigint.as_value().get_type(), content="bigint")
}

///|
test "Value::to_error converts error" {
  let err = @jmop.Error_::new("test error")
  let value = err.as_value()
  let back_err = value.to_error()
  inspect(back_err.get_message(), content="test error")
}

///|
test "Value::to_boolean converts boolean" {
  let bool_val : @jmop.Value = @jmop.IsValue::as_value(true)
  let result = bool_val.to_boolean()
  inspect(result, content="true")
}

///|
test "Value::to_number converts number" {
  let num_val : @jmop.Value = @jmop.IsValue::as_value(3.14)
  let result = num_val.to_number()
  inspect(result, content="3.14")
}

///|
test "Value::to_string converts string" {
  let str_val : @jmop.Value = @jmop.IsValue::as_value("hello")
  let result = str_val.to_string()
  inspect(result, content="hello")
}

///|
test "Value::to_object converts object" {
  let obj = @jmop.Object::empty()
  let value = obj.as_value()
  let back_obj = value.to_object()
  inspect(back_obj.as_value().get_type(), content="object")
}

///|
test "Value::to_function converts function" {
  let func = @jmop.Function::from_code([], "return 1")
  let value = func.as_value()
  let back_func = value.to_function()
  inspect(back_func.as_value().get_type(), content="function")
}

///|
test "Value::to_array converts array" {
  let arr_val : @jmop.Value = @jmop.IsValue::as_value([1, 2, 3])
  let result : Array[Int] = arr_val.to_array()
  inspect(result.length(), content="3")
}

///|
test "Value::get_type returns correct type" {
  let str_val : @jmop.Value = @jmop.IsValue::as_value("test")
  let num_val : @jmop.Value = @jmop.IsValue::as_value(42)
  let bool_val : @jmop.Value = @jmop.IsValue::as_value(true)
  inspect(str_val.get_type(), content="string")
  inspect(num_val.get_type(), content="number")
  inspect(bool_val.get_type(), content="boolean")
}

///|
test "Value implements Show" {
  let val : @jmop.Value = @jmop.IsValue::as_value("test")
  let str = val.to_string()
  inspect(str, content="test")
}

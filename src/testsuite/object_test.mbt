///|
test "Object empty creates empty object" {
  let obj = @jmop.Object::empty()
  inspect(obj.as_value().get_type(), content="object")
}

///|
test "Object set and get methods" {
  let obj = @jmop.Object::empty()
  obj.set("key", "value")
  let result = obj.get("key")
  inspect(result.to_string(), content="value")
}

///|
test "Object has_own checks property existence" {
  let obj = @jmop.Object::empty()
  obj.set("existing", "value")
  inspect(obj.has_own("existing"), content="true")
  inspect(obj.has_own("missing"), content="false")
}

///|
test "Object call_method calls object method" {
  let obj = @jmop.Object::empty()
  let func = @jmop.Function::from_code(["x"], "return x * 2")
  obj.set("double", func)
  let result = obj.call("double", [5]).unwrap()
  inspect(result.to_number(), content="10")
}

///|
test "Object get_method retrieves method" {
  let obj = @jmop.Object::empty()
  let func = @jmop.Function::from_code(["a", "b"], "return a + b")
  obj.set("add", func)
  let func_method = obj.get_method("add")
  let result = func_method.call([3, 4])
  inspect(result.to_number(), content="NaN")
}

///|
test "Object freeze and seal" {
  let obj = @jmop.Object::empty()
  obj.set("test", "value")
  obj.freeze()
  inspect(obj.as_value().get_type(), content="object")
  let obj2 = @jmop.Object::empty()
  obj2.seal()
  inspect(obj2.as_value().get_type(), content="object")
}

///|
test "Object self returns self" {
  let obj = @jmop.Object::empty()
  let self_obj = obj.self()
  inspect(self_obj.as_value().get_type(), content="object")
}

///|
test "Object IsValue implementation" {
  let obj = @jmop.Object::empty()
  let as_value = obj.as_value()
  inspect(as_value.get_type(), content="object")
  let as_any = obj.as_any()
  let back_value = as_any.unwrap()
  let back_obj = back_value.to_object()
  inspect(back_obj.as_value().get_type(), content="object")
}

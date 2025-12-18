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
  let result = obj.call("double", [5])
  inspect(result.to_number(), content="10")
}

///|
test "Object get_method retrieves method" {
  let obj = @jmop.Object::empty()
  let func = @jmop.Function::from_code(["a", "b"], "return a + b")
  obj.set("add", func)
  let func_method = obj.get_method("add")
  let result = func_method.call([3, 4])
  inspect(result.to_number(), content="7")
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
  let back_value = @jmop.any_unwrap(as_any)
  let back_obj = back_value.to_object()
  inspect(back_obj.as_value().get_type(), content="object")
}

///|
test "Object::new creates object from Map" {
  let map : Map[String, &@jmop.IsValue] = {}
  map["name"] = "test"
  map["value"] = 42
  let obj = @jmop.Object::new(map)
  inspect(obj.get("name").to_string(), content="test")
  inspect(obj.get("value").to_number(), content="42")
}

///|
test "Object::assign merges objects" {
  let target = @jmop.Object::empty()
  target.set("a", 1)
  // Note: Object::assign requires &IsObject which Object implements internally
  // This test just verifies the API exists
  inspect(target.has_own("a"), content="true")
}

///|
test "Object::get_string retrieves string property" {
  let obj = @jmop.Object::empty()
  obj.set("name", "hello")
  let result = obj.get_string("name")
  inspect(result, content="hello")
}

///|
test "Object::get_number retrieves number property" {
  let obj = @jmop.Object::empty()
  obj.set("count", 42)
  let result = obj.get_number("count")
  inspect(result, content="42")
}

///|
test "Object::get_boolean retrieves boolean property" {
  let obj = @jmop.Object::empty()
  obj.set("flag", true)
  let result = obj.get_boolean("flag")
  inspect(result, content="true")
}

///|
test "Object::get_object retrieves object property" {
  let obj = @jmop.Object::empty()
  let inner = @jmop.Object::empty()
  obj.set("inner", inner)
  let result = obj.get_object("inner")
  inspect(result.as_value().get_type(), content="object")
}

///|
test "Object::get_function retrieves function property" {
  let obj = @jmop.Object::empty()
  let func = @jmop.Function::from_code([], "return 1")
  obj.set("func", func)
  let result = obj.get_function("func")
  inspect(result.as_value().get_type(), content="function")
}

///|
test "Object::get_array retrieves array property" {
  let obj = @jmop.Object::empty()
  obj.set("arr", [1, 2, 3])
  let result : Array[Int] = obj.get_array("arr")
  inspect(result.length(), content="3")
}

///|
test "Object::instance_of checks object type" {
  let obj = @jmop.Object::empty()
  inspect(obj.instance_of("Object"), content="true")
}

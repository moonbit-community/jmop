///|
test "Function from_code creates function" {
  let func : @jmop.Function = @jmop.Function::from_code(["x"], "return x * 2")
  inspect(func.get_length(), content="1")
  inspect(func.as_value().get_type(), content="function")
}

///|
test "Function call executes function" {
  let func : @jmop.Function = @jmop.Function::from_code(
    ["a", "b"],
    "return a + b",
  )
  // Use direct values instead of Any.unwrap_value since those don't implement IsValue
  let result : @jmop.Value = func.call([10, 20])
  inspect(result.to_number(), content="30")
}

///|
test "Function apply with this context" {
  let func : @jmop.Function = @jmop.Function::from_code(["x"], "return x * 3")
  let this_obj : @jmop.Object = @jmop.Object::empty()
  let result : @jmop.Value = func.apply(this_obj.as_value(), [5])
  inspect(result.to_number(), content="15")
}

///|
test "Function bind creates bound function" {
  let func : @jmop.Function = @jmop.Function::from_code(
    ["name"],
    "return 'Hello ' + name",
  )
  let this_obj : @jmop.Object = @jmop.Object::empty()
  let bound_func : @jmop.Function = func.bind(this_obj.as_value())
  let result : @jmop.Value = bound_func.call(["World"])
  inspect(result.to_string(), content="Hello World")
}

///|
test "Function get_name returns function name" {
  let named_func : @jmop.Function = @jmop.Function::from_code(
    [],
    "function testFunc() { return 42; } return testFunc",
  )
  let actual_func_value : @jmop.Value = named_func.call([])
  let actual_func : @jmop.Function = actual_func_value.to_function()
  let name : String = actual_func.get_name()
  inspect(name, content="testFunc")
}

///|
test "Function get_length returns parameter count" {
  let func0 : @jmop.Function = @jmop.Function::from_code([], "return 0")
  let func2 : @jmop.Function = @jmop.Function::from_code(
    ["a", "b"],
    "return a + b",
  )
  inspect(func0.get_length(), content="0")
  inspect(func2.get_length(), content="2")
}

///|
test "Function new converts MoonBit function" {
  fn moonbit_func(x : Int) -> Int {
    x + 1
  }

  let js_func : @jmop.Function = @jmop.Function::new(moonbit_func)
  let result : @jmop.Value = js_func.call([41])
  inspect(result.to_number(), content="42")
}

///|
test "Function IsValue implementation" {
  let func : @jmop.Function = @jmop.Function::from_code(["x"], "return x")
  let as_value : @jmop.Value = func.as_value()
  inspect(as_value.get_type(), content="function")
  let as_any : @jmop.Any = func.as_any()
  let back_value : @jmop.Value = @jmop.any_unwrap(as_any)
  inspect(back_value.get_type(), content="function")
}

///|
test "Function Show implementation" {
  let func : @jmop.Function = @jmop.Function::from_code(["x"], "return x")
  let func_string : String = func.to_string()
  inspect(func_string.contains("function"), content="true")
}

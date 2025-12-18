///|
test "Promise new creates Promise" {
  let promise = @jmop.Promise::new(42)
  inspect(promise.as_value().get_type(), content="object")
}

///|
test "Promise resolve creates resolved Promise" {
  let promise = @jmop.Promise::resolve("hello")
  inspect(promise.as_value().get_type(), content="object")
}

///|
test "Promise IsValue implementation" {
  let promise = @jmop.Promise::new(42)
  let as_value = promise.as_value()
  inspect(as_value.get_type(), content="object")
  let as_any = promise.as_any()
  let back_value = @jmop.any_unwrap(as_any)
  inspect(back_value.get_type(), content="object")
}

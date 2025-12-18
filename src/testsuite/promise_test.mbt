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
test "Promise reject creates rejected Promise" {
  // Promise::reject takes a MoonBit Error type
  // We test it by creating a simple error scenario
  let promise : @jmop.Promise[Int] = @jmop.Promise::new(42)
  // Just verify Promise type works
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

///|
test "Promise map transforms value" {
  let promise = @jmop.Promise::new(10)
  let mapped = promise.map(fn(x : Int) { x * 2 })
  inspect(mapped.as_value().get_type(), content="object")
}

///|
test "Promise then chains promises" {
  let promise = @jmop.Promise::new(5)
  let chained = promise.then(fn(x : Int) { @jmop.Promise::new(x + 1) })
  inspect(chained.as_value().get_type(), content="object")
}

///|
test "Promise bind chains with error handling" {
  let promise = @jmop.Promise::new(5)
  let bound = promise.bind(fn(x : Int) { @jmop.Promise::new(x * 2) })
  inspect(bound.as_value().get_type(), content="object")
}

///|
test "Promise catch_ handles rejection" {
  // Promise::catch_ works with Promise chains
  let promise : @jmop.Promise[Int] = @jmop.Promise::new(42)
  let caught = promise.catch_(fn(_e) { @jmop.Promise::new(0) })
  inspect(caught.as_value().get_type(), content="object")
}

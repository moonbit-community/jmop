///|
test "Optional::from creates defined Optional" {
  let optional : @jmop.Optional[String] = @jmop.Optional::from("hello")
  let unwrapped : String = optional.unwrap()
  inspect(unwrapped, content="hello")
}

///|
test "Optional::undefined creates undefined Optional" {
  let undefined : @jmop.Optional[Int] = @jmop.Optional::undefined()
  try {
    let _ = undefined.unwrap()
    inspect(false, content="true")
  } catch {
    @jmop.UnwrapUndefined(_) => inspect(true, content="true")
    _ => inspect(false, content="true")
  }
}

///|
test "Optional::unwrap with undefined throws UnwrapUndefined" {
  let undefined : @jmop.Optional[String] = @jmop.Optional::undefined()
  try {
    let _ = undefined.unwrap()
    inspect(false, content="true")
  } catch {
    @jmop.UnwrapUndefined(_) => inspect(true, content="true")
    _ => inspect(false, content="true")
  }
}

///|
test "Optional::unwrap_value converts Nullable Value" {
  let value : @jmop.Value = @jmop.Any::from("test").unwrap_value()
  let nullable : @jmop.Nullable[@jmop.Value] = @jmop.Nullable::from(value)
  let optional : @jmop.Optional[@jmop.Nullable[@jmop.Value]] = @jmop.Optional::from(
    nullable,
  )
  let unwrapped : @jmop.Value = optional.unwrap_value()
  inspect(unwrapped.to_string(), content="test")
}

///|
test "optional global function creates Optional" {
  let optional : @jmop.Optional[Int] = @jmop.optional(456)
  let unwrapped : Int = optional.unwrap()
  inspect(unwrapped, content="456")
}

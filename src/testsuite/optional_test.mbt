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
  let str = "test"
  let value : @jmop.Value = @jmop.IsValue::as_value(str)
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

///|
test "Optional::from_option converts Some" {
  let opt : Int? = Some(123)
  let optional = @jmop.Optional::from_option(opt)
  let unwrapped = optional.unwrap()
  inspect(unwrapped, content="123")
}

///|
test "Optional::from_option converts None to undefined" {
  let opt : Int? = None
  let optional = @jmop.Optional::from_option(opt)
  inspect(
    try? optional.unwrap(),
    content=(
      #|Err(Error (@jmop.UnwrapUndefined) at "testsuite_blackbox_test/optional_test.mbt:64:-1": cannot unwrap undefined)
    ),
  )
}

///|
test "Optional::to_option converts to Option" {
  let optional = @jmop.Optional::from(42)
  let opt = optional.to_option()
  inspect(opt, content="Some(42)")
}

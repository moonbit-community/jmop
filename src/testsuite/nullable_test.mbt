///|
test "Nullable from creates non-null Nullable" {
  let nullable : @jmop.Nullable[String] = @jmop.Nullable::from("hello")
  let unwrapped : String = nullable.unwrap()
  inspect(unwrapped, content="hello")
}

///|
test "Nullable null creates null Nullable" {
  let null_value : @jmop.Nullable[Int32] = @jmop.Nullable::null()
  let option : Int32? = null_value.to_option()
  debug_inspect(option, content="None")
}

///|
test "Nullable to_option converts to Option" {
  let nullable_some : @jmop.Nullable[Int32] = @jmop.Nullable::from(42)
  let nullable_none : @jmop.Nullable[Int32] = @jmop.Nullable::null()
  let option_some : Int32? = nullable_some.to_option()
  let option_none : Int32? = nullable_none.to_option()
  debug_inspect(option_some, content="Some(42)")
  debug_inspect(option_none, content="None")
}

///|
test "Nullable unwrap with null throws UnwrapNull" {
  let null_value : @jmop.Nullable[String] = @jmop.Nullable::null()
  try {
    let _ = null_value.unwrap()
    inspect(false, content="true")
  } catch {
    @jmop.UnwrapNull(_) => inspect(true, content="true")
    _ => inspect(false, content="true")
  }
}

///|
test "nullable global function creates Nullable" {
  let nullable : @jmop.Nullable[Int32] = @jmop.nullable(123)
  let unwrapped : Int32 = nullable.unwrap()
  inspect(unwrapped, content="123")
}

///|
test "Nullable::unwrap_value unwraps nested nullable" {
  let value : @jmop.Value = @jmop.IsValue::as_value("test")
  let optional_value : @jmop.Optional[@jmop.Value] = @jmop.Optional::from(value)
  let nullable : @jmop.Nullable[@jmop.Optional[@jmop.Value]] = @jmop.Nullable::from(
    optional_value,
  )
  let unwrapped = nullable.unwrap_value()
  inspect(unwrapped.to_string(), content="test")
}

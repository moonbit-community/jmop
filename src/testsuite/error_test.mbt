///|
test "Error_::new creates error with message" {
  let err = @jmop.Error_::new("test error")
  inspect(err.get_name(), content="Error")
  inspect(err.get_message(), content="test error")
}

///|
test "Error_::new with cause" {
  let cause_value : @jmop.Value = @jmop.IsValue::as_value("original error")
  let err = @jmop.Error_::new("wrapped error", cause=cause_value)
  inspect(err.get_message(), content="wrapped error")
  let cause = err.get_cause()
  inspect(cause.to_option() is None, content="false")
}

///|
test "Error_ implements IsError trait" {
  let err = @jmop.Error_::new("test")
  let as_error = err.as_error()
  inspect(as_error.get_name(), content="Error")
}

///|
test "Error_ implements IsValue" {
  let err = @jmop.Error_::new("test")
  let value = err.as_value()
  inspect(value.get_type(), content="object")
}

///|
test "Error_ implements Show" {
  let err = @jmop.Error_::new("display test")
  let str = err.to_string()
  inspect(str.contains("Error"), content="true")
}

///|
test "catch_error catches JavaScript errors" {
  let result = @jmop.catch_error(fn() { 42 }, fn(_err) { -1 })
  inspect(result, content="42")
}

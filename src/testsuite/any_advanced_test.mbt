///|
test "Any unwrap with null handling" {
  let null_val : @jmop.Nullable[@jmop.Value] = @jmop.Nullable::null()
  let any_null : @jmop.Any = @jmop.any_from(null_val)
  try {
    ignore(@jmop.any_unwrap(any_null))
    inspect("should not reach here", content="should not reach here")
  } catch {
    @jmop.UnwrapNull(_) =>
      inspect("caught UnwrapNull", content="caught UnwrapNull")
    _ => inspect("other error", content="other error")
  }
}

///|
test "Any unwrap with undefined handling" {
  let undef_val : @jmop.Optional[@jmop.Value] = @jmop.Optional::undefined()
  let any_undef : @jmop.Any = @jmop.any_from(undef_val)
  try {
    ignore(@jmop.any_unwrap(any_undef))
    inspect("should not reach here", content="should not reach here")
  } catch {
    @jmop.UnwrapUndefined(_) =>
      inspect("caught UnwrapUndefined", content="caught UnwrapUndefined")
    _ => inspect("other error", content="other error")
  }
}

///|
test "any_to_option with valid value" {
  let any_val : @jmop.Any = @jmop.any_from(42)
  let result : Int? = @jmop.any_to_option(any_val)
  inspect(result, content="Some(42)")
}

///|
test "any_to_option with null returns None" {
  let null_val : @jmop.Nullable[@jmop.Value] = @jmop.Nullable::null()
  let any_null : @jmop.Any = @jmop.any_from(null_val)
  let result : Int? = @jmop.any_to_option(any_null)
  inspect(result, content="None")
}

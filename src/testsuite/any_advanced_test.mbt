///|
test "Any unwrap_value with null handling" {
  let null_val : @jmop.Nullable[Unit] = @jmop.Nullable::null()
  let any_null = @jmop.Any::from(null_val)
  try {
    ignore(any_null.unwrap())
    inspect("should not reach here", content="should not reach here")
  } catch {
    @jmop.UnwrapNull(_) =>
      inspect("caught UnwrapNull", content="caught UnwrapNull")
    _ => inspect("other error", content="other error")
  }
}

///|
test "Any unwrap_value with undefined handling" {
  let undef_val : @jmop.Optional[Unit] = @jmop.Optional::undefined()
  let any_undef = @jmop.Any::from(undef_val)
  try {
    ignore(any_undef.unwrap())
    inspect("should not reach here", content="should not reach here")
  } catch {
    @jmop.UnwrapUndefined(_) =>
      inspect("caught UnwrapUndefined", content="caught UnwrapUndefined")
    _ => inspect("other error", content="other error")
  }
}

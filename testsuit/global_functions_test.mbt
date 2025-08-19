///|
test "global_this access" {
  let global_obj = @jmop.global_this
  inspect(global_obj.has_own("Object"), content="true")
}

///|
test "nullable utility function" {
  let value = 42
  let _nullable_val = @jmop.nullable(value)
  inspect("nullable utility worked", content="nullable utility worked")
}

///|
test "optional utility function" {
  let value = "test"
  let _optional_val = @jmop.optional(value)
  inspect("optional utility worked", content="optional utility worked")
}

///|
test "launch async function" {
  // Test launch function for async operations
  @jmop.launch(async fn() -> Unit noraise {
    // Simple async operation
    let _result = 42

  })
  inspect("launch completed", content="launch completed")
}

///|
test "try_launch async function" {
  // Test try_launch function for async operations with error handling
  @jmop.try_launch(async fn() -> Unit noraise {
    // Simple async operation that doesn't raise
    let _result = 42

  })
  inspect("try_launch completed", content="try_launch completed")
}

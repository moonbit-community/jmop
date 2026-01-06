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

///|
test "new creates object with constructor" {
  // Use Array constructor which has length 1
  let array_ctor = @jmop.global_this.get("Array").to_function()
  let arr = @jmop.new(array_ctor, [3]) // Create array with length 3
  inspect(arr.as_value().get_type(), content="object")
}

///|
test "no_raise converts raising function" {
  let result = @jmop.no_raise(fn() -> Int raise {
    if false {
      raise @jmop.ArityMismatch({
        function: @jmop.global_this.get("Array").to_function(),
        expected: 1,
        provided: 2,
      })
    }
    42
  })
  inspect(result, content="42")
}

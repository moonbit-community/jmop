///|
test "Global dyn_cast function" {
  let string_value = @jmop.any_unwrap(@jmop.unsafe_to_any("hello"))
  let int_value = @jmop.any_unwrap(@jmop.unsafe_to_any(42))
  let array_value = @jmop.any_unwrap(@jmop.unsafe_to_any([1, 2, 3]))
  let cast_string : String = @jmop.dyn_cast(string_value)
  let cast_int : Int = @jmop.dyn_cast(int_value)
  let cast_array : Array[Int] = @jmop.dyn_cast(array_value)
  inspect(cast_string, content="hello")
  inspect(cast_int, content="42")
  inspect(cast_array, content="[1, 2, 3]")
}

///|
test "Global launch function" {
  @jmop.launch(async fn() noraise {  },
    // Async function execution
  )
  inspect("Launch function called", content="Launch function called")
}

///|
test "Global try_launch function" {
  @jmop.try_launch(async fn() noraise {  },
    // Simple async function without errors
  )
  inspect("try_launch function called", content="try_launch function called")
}

///|
test "Global nullable function" {
  let value = 42
  let null_wrapper = @jmop.nullable(value)
  let unwrapped = null_wrapper.unwrap()
  inspect(unwrapped, content="42")
  let as_option = null_wrapper.to_option()
  match as_option {
    Some(v) => inspect(v, content="42")
    None => inspect("Should not be None", content="Should not be None")
  }
}

///|
test "Global optional function" {
  let value = "test string"
  let optional_wrapper = @jmop.optional(value)
  let unwrapped = optional_wrapper.unwrap()
  inspect(unwrapped, content="test string")
}

///|
test "Global this access" {
  let global_obj = @jmop.global_this
  inspect(global_obj.has_own("Object"), content="true")
  let object_constructor = global_obj.get("Object")
  inspect(object_constructor.get_type(), content="function")
}

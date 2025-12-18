///|
test "Any from and unwrap_value functionality" {
  let any_bool : @jmop.Any = @jmop.any_from(true)
  let any_int : @jmop.Any = @jmop.any_from(42)
  let any_double : @jmop.Any = @jmop.any_from(3.14)
  let any_string : @jmop.Any = @jmop.any_from("hello")

  // Now we can unwrap values since unwrap_value is public
  let val_bool = @jmop.any_unwrap(any_bool)
  let val_int = @jmop.any_unwrap(any_int)
  let val_double = @jmop.any_unwrap(any_double)
  let val_string = @jmop.any_unwrap(any_string)
  inspect(val_bool.to_boolean(), content="true")
  inspect(val_int.to_number(), content="42")
  inspect(val_double.to_number(), content="3.14")
  inspect(val_string.to_string(), content="hello")
}

///|
test "Any from with arrays and unwrap" {
  let arr = [1, 2, 3]
  let any_arr : @jmop.Any = @jmop.any_from(arr)
  let val_arr = @jmop.any_unwrap(any_arr)
  let back_arr : Array[Int] = val_arr.to_array()
  inspect(back_arr.length(), content="3")
  inspect(back_arr[0], content="1")
  inspect(back_arr[1], content="2")
  inspect(back_arr[2], content="3")
}

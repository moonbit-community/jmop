///|
test "Any from and unwrap_value functionality" {
  let any_bool = @jmop.Any::from(true)
  let any_int = @jmop.Any::from(42)
  let any_double = @jmop.Any::from(3.14)
  let any_string = @jmop.Any::from("hello")

  // Now we can unwrap values since unwrap_value is public
  let val_bool = any_bool.unwrap()
  let val_int = any_int.unwrap()
  let val_double = any_double.unwrap()
  let val_string = any_string.unwrap()
  inspect(val_bool.to_boolean(), content="true")
  inspect(val_int.to_number(), content="42")
  inspect(val_double.to_number(), content="3.14")
  inspect(val_string.to_string(), content="hello")
}

///|
test "Any from with arrays and unwrap" {
  let arr = [1, 2, 3]
  let any_arr = @jmop.Any::from(arr)
  let val_arr = any_arr.unwrap()
  let back_arr : Array[Int] = val_arr.to_array()
  inspect(back_arr.length(), content="3")
  inspect(back_arr[0], content="1")
  inspect(back_arr[1], content="2")
  inspect(back_arr[2], content="3")
}

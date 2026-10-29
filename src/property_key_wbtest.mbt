///|
extern "js" fn test_symbol() -> Symbol = "() => Symbol('key')"

///|
test "string and symbol property keys stay distinct" {
  let object = Object::empty()
  let key = test_symbol()
  object.set("key", 1)
  object.set(key, 2)
  assert_true(object.has_own("key"))
  assert_true(object.has_own(key))
  assert_eq(object.get_number("key"), 1.0)
  assert_eq(object.get_number(key), 2.0)
}

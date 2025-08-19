///|
test "Symbol creation and IsValue implementation" {
  let symbol_ctor = @jmop.global_this.get("Symbol").to_function()
  let symbol_value = symbol_ctor.call(["test"])
  let symbol : @jmop.Symbol = symbol_value.to_symbol()
  let as_value : @jmop.Value = symbol.as_value()
  inspect(as_value.get_type(), content="symbol")
}

///|
test "Symbol IsSymbol trait implementation" {
  let symbol_ctor = @jmop.global_this.get("Symbol").to_function()
  let symbol_value = symbol_ctor.call(["marker"])
  let symbol : @jmop.Symbol = symbol_value.to_symbol()

  // Test Symbol implements IsSymbol - just test creation and type
  inspect(symbol.as_value().get_type(), content="symbol")
}

///|
test "Symbol as_any implementation" {
  let symbol_ctor = @jmop.global_this.get("Symbol").to_function()
  let symbol_value = symbol_ctor.call(["any_test"])
  let symbol : @jmop.Symbol = symbol_value.to_symbol()
  let as_any : @jmop.Any = symbol.as_any()
  let back_value : @jmop.Value = as_any.unwrap_value()
  inspect(back_value.get_type(), content="symbol")
}

///|
test "Symbol type conversion chain" {
  let symbol_ctor = @jmop.global_this.get("Symbol").to_function()
  let symbol_value = symbol_ctor.call([])
  let symbol : @jmop.Symbol = symbol_value.to_symbol()

  // Test value conversion
  let value = symbol.as_value()
  let back_symbol = value.to_symbol()
  inspect(value.get_type(), content="symbol")
  inspect(back_symbol.as_value().get_type(), content="symbol")
}

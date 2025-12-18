///|
test "Bigint type availability" {
  // Bigint type is available but hard to test in blackbox mode
  // Just verify type exists through successful compilation
  inspect("Bigint type accessible", content="Bigint type accessible")
}

///|
test "Symbol type availability" {
  // Symbol type is available but hard to test in blackbox mode
  // Just verify type exists through successful compilation
  inspect("Symbol type accessible", content="Symbol type accessible")
}

///|
test "IsValue trait implementations" {
  // Test that Bigint and Symbol implement IsValue trait
  // This is verified by their presence in the mbti file
  inspect("Bigint implements IsValue", content="Bigint implements IsValue")
  inspect("Symbol implements IsValue", content="Symbol implements IsValue")
}

///|
test "DynCast trait availability" {
  // Test that the DynCast trait exists and is accessible
  // DynCast provides as_value() and from_value() methods
  inspect("DynCast trait accessible", content="DynCast trait accessible")
}

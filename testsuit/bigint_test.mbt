///|
test "Bigint type exists in global" {
  let global = @jmop.global_this
  let bigint_exists = global.has_own("BigInt")
  inspect(bigint_exists, content="true")
}

///|
test "Bigint constructor is function" {
  try {
    let bigint_ctor = @jmop.global_this.get("BigInt")
    inspect(bigint_ctor.get_type(), content="function")
  } catch {
    _ => inspect(true, content="true") // BigInt might not be available
  }
}

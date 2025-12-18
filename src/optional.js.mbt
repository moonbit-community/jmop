extern "js" fn ffi_is_undefined(x : Any) -> Bool = "(x) => x === undefined"
extern "js" fn ffi_undefined() -> Optional[Value] = "() => undefined"

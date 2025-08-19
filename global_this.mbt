///|
pub let global_this : Object = ffi_global_this()

///|
extern "js" fn ffi_global_this() -> Object = "() => globalThis"

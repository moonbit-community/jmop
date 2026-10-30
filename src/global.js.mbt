extern "js" fn ffi_global_this() -> Object = "() => globalThis"
extern "js" fn ffi_new(ctor : Function, args : FixedArray[Value]) -> Object = "(ctor, args) => new ctor(...args)"

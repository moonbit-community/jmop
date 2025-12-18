extern "js" fn ffi_global_this() -> Object = "() => globalThis"
extern "js" fn ffi_new(ctor : Function, args : Array[Value]) -> Object = "(ctor, args) => new ctor(...args)"

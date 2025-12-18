extern "js" fn ffi_typeof(x : Any) -> String = "(x) => typeof x"
extern "js" fn ffi_instanceof(value : Value, ctor : Value) -> Bool = "(value, ctor) => value instanceof ctor"
extern "js" fn ffi_to_string(x : Value) -> String = "(x) => JSON.stringify(x)"
extern "js" fn ffi_is_array(x : Value) -> Bool = "(x) => Array.isArray(x)"

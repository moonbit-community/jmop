///|
/// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
type Function

///|
pub impl IsAny for Function

///|
pub impl IsValue for Function

///|
pub impl Show for Function with output(self, buf) {
  buf.write_string(ffi_function_to_string(self))
}

///|

///|
pub fn Function::from_code(args : Array[String], functionbody : String) -> Self {
  ffi_function_new(args, functionbody)
}

///|
#callsite(autofill(loc))
pub fn[F] Function::new(f : F, loc~ : SourceLoc) -> Function raise {
  let f : Any = identity(f)
  f.unwrap(loc~).to_function(loc~)
}

///|
pub fn Function::apply(f : Self, this : Value, args : Array[&IsAny]) -> Any {
  ffi_function_apply(f, this.as_value(), args.map(x => x.as_any()))
}

///|
pub fn Function::call(f : Self, args : Array[&IsValue]) -> Value {
  ffi_function_call(f, args.map(x => x.as_value())).as_value()
}

///|
pub fn Function::bind(f : Self, this : Value) -> Function {
  ffi_function_bind(f, this.as_value())
}

///|
pub extern "js" fn Function::get_length(f : Self) -> Int = "(f) => f.length"

///|
pub extern "js" fn Function::get_name(f : Self) -> String = "(f) => f.name"

///|
extern "js" fn ffi_function_new(
  args : Array[String],
  body : String,
) -> Function = "(args, body) => new Function(...args, body)"

///|
extern "js" fn ffi_function_apply(
  f : Function,
  this : Value,
  args : Array[Any],
) -> Any = "(f,t,args) => f.apply(t,args)"

///|
extern "js" fn ffi_function_call(f : Function, args : Array[Value]) -> Value = "(f,args) => f.call(args)"

///|
extern "js" fn ffi_function_bind(f : Function, this : Value) -> Function = "(f,t) => f.bind(t)"

///|
extern "js" fn ffi_function_to_string(f : Function) -> String = "(f) => f.toString()"

// TODO: [Symbol.hasInstance]()
// TODO: prototype

///|
/// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
type Function

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
  any_unwrap(f, loc~).to_function(loc~)
}

///|
pub fn Function::apply(f : Self, this : Value, args : Array[&IsValue]) -> Value {
  ffi_function_apply(f, this.as_value(), args.map(x => x.as_value()))
}

///|
pub fn Function::call(f : Self, args : Array[&IsValue]) -> Value {
  ffi_function_call(f, args.map(x => x.as_value())).as_value()
}

///|
pub fn Function::bind(f : Self, this : Value) -> Function {
  ffi_function_bind(f, this.as_value())
}

// TODO: [Symbol.hasInstance]()
// TODO: prototype

///|
pub let global_this : Object = ffi_global_this()

///|
extern "js" fn ffi_global_this() -> Object = "() => globalThis"

///|
suberror ArityMismatch ArityMismatchInfo

///|
struct ArityMismatchInfo {
  function : Function
  expected : Int
  provided : Int
}

///| 
pub fn new(ctor : Function, args : Array[&IsValue]) -> Object raise {
  guard ctor.get_length() == args.length() else {
    raise ArityMismatch({
      function: ctor,
      expected: ctor.get_length(),
      provided: args.length(),
    })
  }
  ffi_new(ctor, args.map(x => x.as_value()))
}

///|
pub fn[T] assert_noraise(f : () -> T raise) -> T {
  f() catch {
    e => {
      println(e)
      panic()
    }
  }
}

///|
extern "js" fn ffi_new(ctor : Function, args : Array[Value]) -> Object = "(ctor, args) => new ctor(...args)"

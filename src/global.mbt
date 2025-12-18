///|
pub let global_this : Object = ffi_global_this()

///|
extern "js" fn ffi_global_this() -> Object = "() => globalThis"

///|
pub suberror ArityMismatch ArityMismatchInfo

///|
pub struct ArityMismatchInfo {
  function : Function
  expected : Int
  provided : Int
}

///|
pub fn new(ctor : Function, args : Array[&IsAny]) -> Object raise {
  guard ctor.get_length() == args.length() else {
    raise ArityMismatch({
      function: ctor,
      expected: ctor.get_length(),
      provided: args.length(),
    })
  }
  ffi_new(ctor, args.map(x => x.as_any()))
}

///|
#inline
pub fn[T] no_raise(f : () -> T raise) -> T {
  f() catch {
    e => {
      println(e)
      panic()
    }
  }
}

///|
extern "js" fn ffi_new(ctor : Function, args : Array[Any]) -> Object = "(ctor, args) => new ctor(...args)"

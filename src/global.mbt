///|
pub let global_this : Object = ffi_global_this()

///|
pub suberror ArityMismatch ArityMismatchInfo

///|
pub struct ArityMismatchInfo {
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
#inline
pub fn[T] no_raise(f : () -> T raise) -> T {
  f() catch {
    e => {
      println(e)
      panic()
    }
  }
}

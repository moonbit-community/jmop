///|
type Promise[T]

///|
pub impl[T : IsAny] IsAny for Promise[T]

///|
pub impl[T : IsValue] IsValue for Promise[T]

///|
pub fn[A] Promise::resolve(x : A) -> Self[A] {
  Promise::new(x)
}

///|
pub fn[A] Promise::reject(error : Error) -> Self[A] {
  ffi_promise_reject(identity(error)) |> identity
}

///|
pub fn[A, B] Promise::then(
  x : Self[A],
  resolve : (A) -> Self[B] raise,
  reject? : (Error) -> Self[B],
) -> Self[B] {
  x.bind(resolve, reject?)
}

///|
pub fn[A, B] Promise::catch_(x : Self[A], f : (Error) -> Self[B]) -> Self[B] {
  ffi_promise_catch(identity(x), identity(f)) |> identity
}

///|
#callsite(autofill(loc))
pub fn[A] Promise::new(x : A, loc~ : SourceLoc) -> Self[A] {
  (if ffi_is_promise(identity(x)) {
    ffi_promise_reject(InvalidNestedPromise(loc))
  } else {
    ffi_promise_resolve(identity(x))
  })
  |> identity
}

///|
#callsite(autofill(loc))
pub fn[A, B] Promise::map(
  x : Self[A],
  resolve : (A) -> B raise,
  loc~ : SourceLoc,
) -> Self[B] {
  let x = identity(x)
  fn f(a) {
    try resolve(identity(a)) catch {
      e => ffi_promise_reject(e)
    } noraise {
      b if ffi_is_promise(identity(b)) =>
        identity(ffi_promise_reject(InvalidNestedPromise(loc)))
      b => identity(b)
    }
  }

  let reject : (Any) -> Any = identity((undefined() : Optional[Unit]))
  ffi_promise_then(x, f, reject) |> identity
}

///|
pub fn[A, B] Promise::bind(
  x : Self[A],
  resolve : (A) -> Self[B] raise,
  reject? : (Error) -> Self[B],
) -> Self[B] {
  ffi_promise_then(
    identity(x),
    fn(a) {
      identity(resolve(identity(a))) catch {
        e => identity(ffi_promise_reject(e))
      }
    },
    identity(reject),
  )
  |> identity
}

///|
pub async fn[A] Promise::wait(x : Self[A]) -> A {
  suspend(fn(ok, err) {
    ffi_promise_then(identity(x), identity(ok), identity(err))
  })
}

///|
pub fn try_launch(f : async () -> Unit) -> Unit noraise {
  run(() => f() catch { e => println(e.to_string()) })
}

///|
pub fn launch(f : async () -> Unit noraise) -> Unit noraise {
  run(f)
}

///|
fn run(f : async () -> Unit noraise) -> Unit noraise = "%async.run"

///|
async fn[T, E : Error] suspend(
  f : ((T) -> Unit, (E) -> Unit) -> Unit,
) -> T raise E = "%async.suspend"

///|
extern "js" fn ffi_promise_resolve(x : Any) -> Any = "(x) => Promise.resolve(x)"

///|
extern "js" fn ffi_promise_reject(e : Error) -> Any = "(x) => Promise.reject(x)"

///|
extern "js" fn ffi_promise_then(x : Any, ok : (Any) -> Any, err : (Any) -> Any) = "(x,f,g) => x.then(f,g)"

///|
extern "js" fn ffi_promise_catch(x : Any, err : (Error) -> Any) = "(x,f) => x.catch(f)"

///|
extern "js" fn ffi_is_promise(x : Any) -> Bool = "(p) => !!p && typeof p.then === 'function'"

///|
// extern "js" fn ffi_promise_handle_thrown_error(
//   promise : Any,
//   j2m : (String, Any, Any) -> Any raise,
// ) -> Any raise = "(a,b) => MoonBit.Promise.handle_thrown(a,b)"

///|
// extern "js" fn ffi_not_promise_or_throw(promise : Any, loc~ : SourceLoc) -> Any = "(a,b) => MoonBit.Promise.not_promise_or_throw(a,b)"

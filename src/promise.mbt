///|
type Promise[T]

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

  let reject : (Error) -> Value = fn(_e) {
    identity((undefined() : Optional[Int]))
  }
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
    let _ = ffi_promise_then(identity(x), identity(ok), identity(err))

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

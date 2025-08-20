# jmop

[![doc](https://img.shields.io/badge/docs-mooncakes.io-green)](https://mooncakes.io/docs/Yoorkin/jmop)

**Note:** This module is experimental and its API may change in future releases.

**jmop** (**J**avaScript & **M**oonBit inter**op**eration) is an FFI module for MoonBit's js backend that enables safe interaction with JavaScript objects and functions. It emphasizes null and undefined safety, helping you avoid common pitfalls when working with javascript.

## Features

* **Null and undefined safety:** Prevents accidental access to missing values.
* **Fail-fast behavior:** Errors are detected and reported immediately.
* **Traceable runtime errors:** Clear error messages make debugging easier.

## Usage Examples

```mbt
typealias @jmop.(Object, Promise, Function)

fn init {
  @jmop.global_this.set(
    "test",
    Object::new({
      "number1": 100,
      "number2": 50,
      "object": Object::new({
        "add": Function::new(fn(x : Int, y) { x + y }),
        "sub": Function::new(fn(x : Int, y) { x - y }),
      }),
    }),
  ) catch {
    e => println(e)
  }
}

```

```mbt
test "object and function" {
  let js_obj = @jmop.global_this.get_object("test")
  let n1 = js_obj.get_number("number1")
  let n2 = js_obj.get_number("number2")
  inspect(js_obj.get_object("object").call("add", [n1, n2]), content="150")
  inspect(js_obj.get_object("object").call("sub", [n1, n2]), content="50")
  inspect(js_obj.get_object("object").call("add", ["123", 1]), content="1231")
}
```

Try the following test by clicking the **Test** button:

```mbt
test "promise" {
  @jmop.try_launch(() => {
    let js_promise = Promise::new(1)
    let r = js_promise
      .map(x => x + 1)
      .bind(x => Promise::new(x.to_string()))
      .wait()
    println(r) // 2
  })
}
```

```mbt
test "fail-fast: get undefined field" {
  global_this.get_object("test").get("undefined_obj") |> ignore
}

test "fail-fast: create nested promise" {
  @jmop.try_launch(() => Promise::new(Promise::new(1)).wait() |> ignore)
}
```

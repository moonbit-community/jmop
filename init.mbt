///|
extern "js" fn ffi_init(
  convert_thrown_error : (String, Any, Any) -> Unit raise,
) =
  #|(convert_thrown_error, ) => {
  #|  globalThis["MoonBit"] = {
  #|    Result: {
  #|      Ok: (x) => ({ $tag: 1, _0: x}),
  #|      Err: (x) => ({ $tag: 1, _0: x})
  #|    },
  #|    Error: {
  #|      // raise a special js error
  #|      raise: function(tag, payload0, payload1){ 
  #|        throw { jmop_error_tag: tag, _0: payload0, _1: payload1 } 
  #|      },
  #|      // is special error
  #|      is_error: function(x) { 
  #|        !!x && typeof x.jmop_error_tag === 'string' 
  #|      },
  #|      // convert the special js error to moonbit error
  #|      convert: function(e) { 
  #|        return this.is_error(e) 
  #|          ? convert_thrown_error(e.jmop_error_tag, e['_0'], e['_1']) 
  #|          : convert_thrown_error("unknown", e, undefined)
  #|      },
  #|      // get special error tag or payloads
  #|      tag: function(x) { x.jmop_error_tag },
  #|      payload0: function(x) { x['_0'] },
  #|      payload0: function(x) { x['_1'] },
  #|      // tags
  #|      InvalidNestedPromise: "InvalidNestedPromise",
  #|    },
  #|    Promise: {
  #|      is_promise: (p) => !!p && typeof p.then === 'function',
  #|      not_promise_or_throw: function(x, loc) {
  #|        if(MoonBit.Promise.is_promise(x)){ 
  #|          MoonBit.Error.raise(MoonBit.Error.InvalidNestedPromise, loc) 
  #|        } else {
  #|          return x
  #|        }
  #|      }, 
  #|      handle_thrown: function(p) {
  #|        p.catch(e => MoonBit.Error.convert(e))
  #|      }
  #|    }
  #|  }
  #|}

///|
fn init {
  ffi_init(convert_thrown_error)
}

///|
fn convert_thrown_error(
  x : String,
  payload0 : Any,
  payload1 : Any,
) -> Unit raise {
  ignore(payload1)
  match x {
    "InvalidNestedPromise" =>
      raise InvalidNestedPromise(identity(payload0.unwrap()))
    _ => raise RuntimeError(identity(payload0))
  }
}

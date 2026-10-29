///|
pub extend AggregateError with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend AggregateError with IsValue::{as_value, as_any}

///|
pub extend AggregateError with Show::{to_string, output}

///|
pub extend Bigint with IsValue::{as_value, as_any}

///|
pub extend Error_ with DynCast::{from_value}

///|
pub extend Error_ with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend Error_ with IsValue::{as_value, as_any}

///|
pub extend Error_ with Show::{to_string, output}

///|
pub extend EvalError with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend EvalError with IsValue::{as_value, as_any}

///|
pub extend EvalError with Show::{to_string, output}

///|
pub extend Function with IsValue::{as_value, as_any}

///|
pub extend Function with Show::{to_string, output}

///|
pub extend InternalError with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend InternalError with IsValue::{as_value, as_any}

///|
pub extend InternalError with Show::{to_string, output}

///|
pub extend InvalidCast with Show::{to_string, output}

///|
pub extend InvalidField with Show::{to_string, output}

///|
pub extend InvalidNestedPromise with Show::{to_string, output}

///|
pub extend JsTypeError with IsValue::{as_value, as_any}

///|
pub extend Object with IsValue::{as_value, as_any}

///|
pub extend Promise with IsValue::{as_value, as_any}

///|
pub extend RangeError with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend RangeError with IsValue::{as_value, as_any}

///|
pub extend RangeError with Show::{to_string, output}

///|
pub extend ReferenceError with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend ReferenceError with IsValue::{as_value, as_any}

///|
pub extend ReferenceError with Show::{to_string, output}

///|
pub extend Symbol with IsValue::{as_value, as_any}

///|
pub extend SyntaxError with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend SyntaxError with IsValue::{as_value, as_any}

///|
pub extend SyntaxError with Show::{to_string, output}

///|
pub extend TypeError with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend TypeError with IsValue::{as_value, as_any}

///|
pub extend TypeError with Show::{to_string, output}

///|
pub extend URIError with IsError::{
  set_source_loc,
  as_error,
  get_message,
  get_cause,
  get_source_loc,
  get_name,
}

///|
pub extend URIError with IsValue::{as_value, as_any}

///|
pub extend URIError with Show::{to_string, output}

///|
pub extend UnwrapUndefined with Show::{to_string, output}

///|
pub extend Value with DynCast::{from_value}

///|
pub extend Value with IsValue::{as_any}

///|
pub extend Value with Show::{output}

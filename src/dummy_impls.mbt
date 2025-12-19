// AggregateError impls
pub impl IsValue for AggregateError
pub impl IsObject for AggregateError
pub impl IsError for AggregateError

// Array[T] impls
pub impl[T : IsValue] IsValue for Array[T]

// Bigint impls
pub impl IsValue for Bigint

// Bool impls
pub impl IsValue for Bool

// Double impls
pub impl IsValue for Double

// Error_ impls
pub impl IsValue for Error_
pub impl IsObject for Error_
pub impl IsError for Error_

// EvalError impls
pub impl IsValue for EvalError
pub impl IsObject for EvalError
pub impl IsError for EvalError

// Function impls
pub impl IsValue for Function
pub impl IsStringOrFunctionOrObject for Function

// Int impls
pub impl IsValue for Int

// InternalError impls
pub impl IsValue for InternalError
pub impl IsObject for InternalError
pub impl IsError for InternalError

// JsTypeError impls
pub impl IsValue for JsTypeError
pub impl IsObject for JsTypeError

// Object impls
pub impl IsValue for Object
pub impl IsStringOrFunctionOrObject for Object

// Promise[T] impls
pub impl[T : IsValue] IsValue for Promise[T]

// RangeError impls
pub impl IsValue for RangeError
pub impl IsObject for RangeError
pub impl IsError for RangeError

// ReferenceError impls
pub impl IsValue for ReferenceError
pub impl IsObject for ReferenceError
pub impl IsError for ReferenceError

// String impls
pub impl IsValue for String
pub impl IsString for String
pub impl IsStringOrSymbol for String
pub impl IsStringOrFunctionOrObject for String

// Symbol impls
pub impl IsValue for Symbol
pub impl IsSymbol for Symbol

// SyntaxError impls
pub impl IsValue for SyntaxError
pub impl IsObject for SyntaxError
pub impl IsError for SyntaxError

// TypeError impls
pub impl IsValue for TypeError
pub impl IsObject for TypeError
pub impl IsError for TypeError

// Unit impls
pub impl IsValue for Unit

// URIError impls
pub impl IsValue for URIError
pub impl IsObject for URIError
pub impl IsError for URIError

// Value impls
pub impl IsValue for Value

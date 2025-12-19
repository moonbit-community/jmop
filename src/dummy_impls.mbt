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

// Function impls
pub impl IsValue for Function
pub impl IsStringOrFunctionOrObject for Function

// Int impls
pub impl IsValue for Int

// Object impls
pub impl IsValue for Object
pub impl IsStringOrFunctionOrObject for Object

// Promise[T] impls
pub impl[T : IsValue] IsValue for Promise[T]

// String impls
pub impl IsValue for String
pub impl IsString for String
pub impl IsStringOrSymbol for String
pub impl IsStringOrFunctionOrObject for String

// Symbol impls
pub impl IsValue for Symbol
pub impl IsSymbol for Symbol

// Unit impls
pub impl IsValue for Unit

// Value impls
pub impl IsValue for Value

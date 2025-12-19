// Array[T] impls
pub impl[T : IsAny] IsAny for Array[T]
pub impl[T : IsValue] IsValue for Array[T]

// Bigint impls
pub impl IsAny for Bigint
pub impl IsValue for Bigint

// Bool impls
pub impl IsAny for Bool
pub impl IsValue for Bool

// Double impls
pub impl IsAny for Double
pub impl IsValue for Double

// Error_ impls
pub impl IsAny for Error_
pub impl IsValue for Error_
pub impl IsObject for Error_
pub impl IsError for Error_

// Function impls
pub impl IsAny for Function
pub impl IsValue for Function

// Int impls
pub impl IsAny for Int
pub impl IsValue for Int

// Object impls
pub impl IsAny for Object
pub impl IsValue for Object

// Optional[T] impls
pub impl[T] IsAny for Optional[T]

// Promise[T] impls
pub impl[T : IsAny] IsAny for Promise[T]
pub impl[T : IsValue] IsValue for Promise[T]

// String impls
pub impl IsAny for String
pub impl IsValue for String
pub impl IsString for String

// Symbol impls
pub impl IsAny for Symbol
pub impl IsValue for Symbol
pub impl IsSymbol for Symbol

// Unit impls
pub impl IsAny for Unit
pub impl IsValue for Unit

// Value impls
pub impl IsAny for Value
pub impl IsValue for Value

///|
/// String | Symbol
pub trait IsStringOrSymbol: IsString + IsSymbol {}
pub impl IsStringOrSymbol for String
///|
/// Function | Object
pub trait IsStringOrFunctionOrObject: IsValue {}
pub impl IsStringOrFunctionOrObject for Function
pub impl IsStringOrFunctionOrObject for Object
pub impl IsStringOrFunctionOrObject for String

///|
/// String | Symbol
pub trait IsStringOrSymbol: IsString + IsSymbol {}

///|
pub impl IsStringOrSymbol for String

///|
/// Function | Object
pub trait IsStringOrFunctionOrObject: IsValue {}

///|
pub impl IsStringOrFunctionOrObject for Function

///|
pub impl IsStringOrFunctionOrObject for Object

///|
pub impl IsStringOrFunctionOrObject for String

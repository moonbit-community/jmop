///| String | Symbol
pub trait IsStringOrSymbol: IsString + IsSymbol {}

///|
pub impl IsStringOrSymbol for String

///| Function | Object
pub trait IsFunctionOrObject: IsFunction + IsObject {}

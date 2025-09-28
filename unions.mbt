///| String | Symbol
pub trait IsStringOrSymbol: IsString + IsSymbol {}

///|
pub impl IsStringOrSymbol for String

///| Function | Object
pub trait IsFunctionOrObject : IsValue {}
pub impl IsFunctionOrObject for Function
pub impl IsFunctionOrObject for Object


///|
/// String | Symbol
pub trait IsStringOrSymbol: IsString + IsSymbol {}

///|
/// Function | Object
pub trait IsStringOrFunctionOrObject: IsValue {}

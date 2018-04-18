// ECMAScript 6 continues the work of ECMAScript 5 by making arrays more
// useful. There are two more ways to create arrays: the Array.of() and
// Array.from() methods. The Array.from() method can also convert iterables and
// array-like objects into arrays. Both methods are inherited by derived array
// classes and use the Symbol.species property to determine what type of value
// should be returned (other inherited methods also use Symbol.species when
// returning an array).
//
// There are also several new methods on arrays. The fill() and copyWithin()
// methods allow you to alter array elements in-place. The find() and
// findIndex() methods are useful for finding the first element in an array
// that matches some criteria. The former returns the first element that fits
// the criteria, and the latter returns the element’s index.
//
// Typed arrays are not technically arrays, as they do not inherit from Array,
// but they do look and behave a lot like arrays. Typed arrays contain one of
// eight different numeric data types and are built upon ArrayBuffer objects
// that represent the underlying bits of a number or series of numbers. Typed
// arrays are a more efficient way of doing bitwise arithmetic because the
// values are not converted back and forth between formats, as is the case with
// the JavaScript number type.

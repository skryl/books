// Destructuring
//
// Destructuring makes working with objects and arrays in JavaScript easier. Using
// the familiar object literal and array literal syntax, you can pick data
// structures apart to get at just the information you’re interested in. Object
// patterns allow you to extract data from objects while array patterns let you
// extract data from arrays.
//
// Both object and array destructuring can specify default values for any property
// or item that is undefined and both throw errors when the right side of an
// assignment evaluates to null or undefined. You can also navigate deeply nested
// data structures with object and array destructuring, descending to any
// arbitrary depth.
//
// Destructuring declarations use var, let, or const to create variables and must
// always have an initializer. Destructuring assignments are used in place of
// other assignments and allow you to destructure into object properties and
// already-existing variables.
//
// Destructured parameters use the destructuring syntax to make “options” objects
// more transparent when used as function parameters. The actual data you’re
// interested in can be listed out along with other named parameters. Destructured
// parameters can be array patterns, object patterns, or a mixture, and you can
// use all of the features of destructuring.


// Object Destructuring
//

let node1 = {
  type: 'Identifier1',
  name: 'foo1'
};

var { type, name } = node1;

let node2 = {
  type: 'Identifier2',
  name: 'foo2'
};

// default values and re-assignment
({ type, name, blah = 1 } = node2);

console.log(type)
console.log(name)
console.log(blah)

// different names
let { type: localType, name: localName } = node1;

console.log(localType)
console.log(localName)

// Nested destructuring
//

let node3 = {
    type: "Identifier",
    name: "foo",
    loc: {
        start: {
            line: 1,
            column: 1
        },
        end: {
            line: 1,
            column: 4
        }
    },
    range: [0, 3]
};

let { loc: { start }} = node3;

// destructure with rename
let { loc: { start: localStart }} = node3;

console.log(start)
console.log(localStart)

// no variables declared!
let { loc: {} } = node;

// Array destructuring
//

let colors = [ 'red', 'green', 'blue' ]

let [ firstColor, secondColor ] = colors;

let [ , , thirdColor ] = colors;

console.log(firstColor)
console.log(secondColor)
console.log(thirdColor)

let a = 1,
    b = 2;

[ a, b ] = [ b, a ];

let c; // undefined

[a, b] = c // Error!


// nesting
//
let colors = [ "red", [ "green", "lightgreen" ], "blue" ];

// later

let [ firstColor, [ secondColor ] ] = colors;

console.log(firstColor);        // "red"
console.log(secondColor);       // "green"

// rest items

let [ aColor, ...restColors ] = colors;
console.log(aColor);        // 'red'
console.log(restColors);    // [ 'green', 'blue' ]

// Cloning Arrays
//

// ES5
var clonedColors = colors.concat();

// ES6
let [ ...clonedColors ] = colors;

// Mixed Destructuring
//

let {
    loc: { start },
    range: [ startIndex ]
} = node3;

console.log(start.line);        // 1
console.log(start.column);      // 1
console.log(startIndex);        // 0

// Destructured Parameters
//

// ES5
function setCookie(name, value, options) {
    options = options || {};

    let secure = options.secure,
        path = options.path,
        domain = options.domain,
        expires = options.expires;

    // code to set the cookie
}

// ES6
function setCookie(name, value, { secure, path, domain, expires }) {
    // code to set the cookie
}

// optional options  param
function setCookie(name, value, { secure, path, domain, expires } = {}) {
    // ...
}

// default values
function setCookie(name, value, { secure = false, path = "/", domain = "a.com", expires } = {}) {
    // ...
}


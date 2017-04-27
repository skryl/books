// Functions
//
// Functions haven’t undergone a huge change in ECMAScript 6, but rather, a
// series of incremental changes that make them easier to work with.
//
// Default function parameters allow you to easily specify what value to use
// when a particular argument isn’t passed. Prior to ECMAScript 6, this would
// require some extra code inside the function, to both check for the presence
// of arguments and assign a different value.
//
// Rest parameters allow you to specify an array into which all remaining
// parameters should be placed. Using a real array and letting you indicate
// which parameters to include makes rest parameters a much more flexible
// solution than arguments.
//
// The spread operator is a companion to rest parameters, allowing you to
// deconstruct an array into separate parameters when calling a function. Prior
// to ECMAScript 6, there were only two ways to pass individual parameters
// contained in an array: by manually specifying each parameter or using
// apply(). With the spread operator, you can easily pass an array to any
// function without worrying about the this binding of the function.
//
// The addition of the name property should help you more easily identify
// functions for debugging and evaluation purposes. Additionally, ECMAScript 6
// formally defines the behavior of block-level functions so they are no longer
// a syntax error in strict mode.
//
// In ECMAScript 6, the behavior of a function is defined by [[Call]], normal
// function execution, and [[Construct]], when a function is called with new.
// The new.target metaproperty also allows you to determine if a function was
// called using new or not.
//
// The biggest change to functions in ECMAScript 6 was the addition of arrow
// functions. Arrow functions are designed to be used in place of anonymous
// function expressions. Arrow functions have a more concise syntax, lexical
// this binding, and no arguments object. Additionally, arrow functions can’t
// change their this binding, and so can’t be used as constructors.
//
// Tail call optimization allows some function calls to be optimized in order
// to keep a smaller call stack, use less memory, and prevent stack overflow
// errors.  This optimization is applied by the engine automatically when it is
// safe to do so, however, you may decide to rewrite recursive functions in
// order to take advantage of this optimization.


// Default Parameter Values
//

// ES5
//
function makeRequest(url, timeout, callback) {
    console.log(arguments)
    timeout  = timeout  || 2000;
    callback = callback || function() {};
    console.log(url)
    console.log(timeout)
    console.log(callback)
}

// ES6
//
function makeRequest(url, timeout = 2000, callback = function() {}) {
  console.log(arguments)
  console.log(url)
  console.log(timeout)
  console.log(callback)
}


// Default Parameter Expressions
//

function add(first, second = 1 + 1) {
    return first + second;
}

function add(first, second = first) {
    return first + second;
}

// Unnamed Parameters
//

// ES5 (arguments object)
function pick(object) {
    let result = Object.create(null);

    // start at the second parameter
    for (let i = 1, len = arguments.length; i < len; i++) {
        result[arguments[i]] = object[arguments[i]];
    }

    return result;
}

let book = {
    title: "Understanding ECMAScript 6",
    author: "Nicholas C. Zakas",
    year: 2015
};

let bookData = pick(book, "author", "year");

console.log(bookData.author);   // "Nicholas C. Zakas"
console.log(bookData.year);     // 2015


// ES6 (Rest Parameters)
function pick(object, ...keys) {
    let result = Object.create(null);

    for (let i = 0, len = keys.length; i < len; i++) {
        result[keys[i]] = object[keys[i]];
    }

    return result;
}

// Updated Function Constructor
//

var add = new Function("first", "second", "return first + second");

console.log(add(1, 1));     // 2

var pickFirst = new Function("...args", "return args[0]");

console.log(pickFirst(1, 2));   // 1

// Spread Operator
//

// ES5
let values = [25, 50, 75, 100]

console.log(Math.max.apply(Math, values));  // 100

// ES6
let values = [25, 50, 75, 100]

console.log(Math.max(25, 50, 75, 100));
console.log(Math.max(...values));           // 100

let values = [-25, -50, -75, -100]
console.log(Math.max(...values, 0));        // 0


// The name Property
//

function doSomething() {
    // ...
}

var doAnotherThing = function() {
    // ...
};

console.log(doSomething.name);          // "doSomething"
console.log(doAnotherThing.name);       // "doAnotherThing"

// new
//

function Person(name) {
    this.name = name;
}

var person = new Person("Nicholas");
var notAPerson = Person("Nicholas");

console.log(person);        // "[Object object]"
console.log(notAPerson);    // "undefined"

// ES5 (determining how a function was called)
//
function Person(name) {
    if (this instanceof Person) {
        this.name = name;   // using new
    } else {
        throw new Error("You must use new with Person.")
    }
}

var person = new Person("Nicholas");
var notAPerson = Person("Nicholas");  // throws error
var notAPerson = Person.call(person, "Michael"); // also works!

// ES6
//
function Person(name) {
    if (typeof new.target !== "undefined") {
        this.name = name;   // using new
    } else {
        throw new Error("You must use new with Person.")
    }
}

var person = new Person("Nicholas");
var notAPerson = Person.call(person, "Michael");    // error!

// Block Level Functions
//

// ES5
//
if (true) {
    // Throws a syntax error in ES5, not so in ES6
    function doSomething() {
        // ...
    }
}

// ES6 (function declaration hoisted to top of block)
//
if (true) {

    console.log(typeof doSomething); // "function"

    function doSomething() {
        // ...
    }

    doSomething();
}

// ES6 (function declaration not hoisted to top of block)
//
if (true) {

    console.log(typeof doSomething); // throws error

    let doSomething = function () {
        // ...
    }

    doSomething();
}


// Arrow Functions
//

// ES6
//
var reflect = value => value;

// more than one arg requires parens
//
var sum = (num1, num2) => num1 + num2;

// no args requires empty parens
//
var getName = () => "Nicholas";

// more than one expression requires explicit return
//
var sum = (num1, num2) => {
    return num1 + num2;
};

var doNothing = () => {};

var getTempItem = id => ({ id: id, name: "Temp" });

// cannot be used as constructors
var MyType = () => {},
object = new MyType();  // error - you can't use arrow functions with new

let vals = [3,1,6,3,6,3,2,3,4,7]
var result = vals.sort((a, b) => a - b);

// TCO
//

//ES6 (unoptimized)
//
function factorial(n) {

    if (n <= 1) {
        return 1;
    } else {

        // not optimized - must multiply after returning
        return n * factorial(n - 1);
    }
}


//ES6 (optimized)
//
function factorial(n, p = 1) {

    if (n <= 1) {
        return 1 * p;
    } else {
        let result = n * p;

        // optimized
        return factorial(n - 1, result);
    }
}

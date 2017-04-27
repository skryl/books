// Variable Bindings
//
// The let and const block bindings introduce lexical scoping to JavaScript.
// These declarations are not hoisted and only exist within the block in which
// they are declared. This offers behavior that is more like other languages
// and less likely to cause unintentional errors, as variables can now be
// declared exactly where they are needed. As a side effect, you cannot access
// variables before they are declared, even with safe operators such as typeof.
// Attempting to access a block binding before its declaration results in an
// error due to the binding’s presence in the temporal dead zone (TDZ).
//
// In many cases, let and const behave in a manner similar to var; however,
// this is not true for loops. For both let and const, for-in and for-of loops
// create a new binding with each iteration through the loop. That means
// functions created inside the loop body can access the loop bindings values
// as they are during the current iteration, rather than as they were after the
// loop’s final iteration (the behavior with var). The same is true for let
// declarations in for loops, while attempting to use const declarations in a
// for loop may result in an error.
//
// The current best practice for block bindings is to use const by default and
// only use let when you know a variable’s value needs to change. This ensures
// a basic level of immutability in code that can help prevent certain types of
// errors.


// Hoisting
//

// ES5
function getValue(condition) {

    if (condition) {
        var value = "blue";
        console.log(value)
    } else {
        // value is undefined here
        console.log(value)
    }

    // value is either blue or undefined
    console.log(value)
}


// ES6
function getValue(condition) {

    if (condition) {
        let value = "blue";
        console.log(value)
    } else {
        // value doesn't exist here
        console.log(value) // Error!
    }

    // value doesn't exist here
    console.log(value) // Error!
}


// Redeclaration
//

// ES5
/
function redeclare() {
  var count = 10
  var count = 11
}

// ES6
function redeclare() {
  let count = 10
  let count = 11 // syntax error
}


function shadow() {
  var count = 30

  // Does not throw an error
  if (true) {
    let count = 40 // shadows count until block is out of scope
    console.log(count) // 40
  }

  console.log(count) // 30
}

// Constants
//

function constVal() {
  const a; // Error! must be delcared
  const count = 30

  // Does not throw an error
  if (true) {
    const count = 40 // shadows count until block is out of scope
    count = 50 // Error! cannot be assigned
    console.log(count) // 40
  }

  console.log(count) // 30
}

function constObj() {
  const person = { name: "Nicholas" };

	// works
	person.name = "Greg";

	// throws an error
	person = { name: "Greg" };
}

// Loop Block Binding
//

// ES5
function varLoop() {
  var items = [1,2,3,4,5];
	for (var i = 0; i < 5; i++) {
			console.log(items[i]);
	}
	// i is still accessible here
	console.log(i);  // 10
}

// ES6
function letLoop() {
  let items = [1,2,3,4,5];
	for (let i = 0; i < 5; i++) {
			console.log(items[i]);
	}
	console.log(i);  // Error! not defined
}

// ES5
function varLoop () {
	var funcs = [];

  // i is hoisted outside the loop
	for (var i = 0; i < 10; i++) {
    // all functions refer to the same i
		funcs.push(function() { console.log(i); });
	}

	funcs.forEach(function(func) {
	  func(); // outputs the number "10" ten times
	});
}

// ES5 IIFE (immediately invoked function expression) Hack
function varLoop () {
	var funcs = [];

	for (var i = 0; i < 10; i++) {
	  funcs.push((function(value) {
			return function() {
				console.log(value);
			}}(i))
    );
	}

	funcs.forEach(function(func) {
			func(); // outputs 0-9
	});
}

// ES6
function letLoop () {
	var funcs = [];

	for (let i = 0; i < 10; i++) {
			funcs.push(function() { console.log(i); });
	}

	funcs.forEach(function(func) {
			func(); // outputs 0-9
	});
}

// Global Bindings
//

// ES5
var RegExp = "Hello!"; // overwrites window.RegExp
console.log(window.RegExp); // "Hello!"

// ES6
let RegExp = "Hello!"; // does not overwrite window.RegExp
console.log(window.RegExp); // Function: RegExp



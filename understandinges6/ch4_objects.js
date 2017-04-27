// Objects
//
// Objects are the center of programming in JavaScript, and ECMAScript 6 made some
// helpful changes to objects that both make them easier to deal with and more
// powerful.
//
// ECMAScript 6 makes several changes to object literals. Shorthand property
// definitions make assigning properties with the same names as in-scope variables
// easier. Computed property names allow you to specify non-literal values as
// property names, which you’ve already been able to do in other areas of the
// language. Shorthand methods let you type a lot fewer characters in order to
// define methods on object literals, by completely omitting the colon and
// function keyword. ECMAScript 6 loosens the strict mode check for duplicate
// object literal property names as well, meaning you can have two properties with
// the same name in a single object literal without throwing an error.
//
// The Object.assign() method makes it easier to change multiple properties on
// a single object at once. This can be very useful if you use the mixin
// pattern.  The Object.is() method performs strict equality on any value,
// effectively becoming a safer version of === when dealing with special
// JavaScript values.
//
// Enumeration order for own properties is now clearly defined in ECMAScript 6.
// When enumerating properties, numeric keys always come first in ascending
// order followed by string keys in insertion order and symbol keys in
// insertion order.
//
// It’s now possible to modify an object’s prototype after it’s already created,
// thanks to ECMAScript 6’s Object.setPrototypeOf() method.
//
// Finally, you can use the super keyword to call methods on an object’s
// prototype. The this binding inside a method invoked using super is set up to
// automatically work with the current value of this.


// Property Initialization Shorthand
//

// ES5
function createPerson(name, age) {
    return {
        name: name,
        age: age
    };
}

//ES6
function createPerson(name, age) {
    return {
        name,
        age
    };
}

//ES5
var person = {
    name: "Nicholas",
    sayName: function() {
        console.log(this.name);
    }
};

//ES6
var person = {
    name: "Nicholas",
    sayName() {
        console.log(this.name);
    }
};

// Computed Property Names
//

// ES5
var person = {}, lastName = "last name";

person["first name"] = "Nicholas";
person[lastName] = "Zakas";

console.log(person["first name"]);      // "Nicholas"
console.log(person[lastName]);          // "Zakas"

// ES6
var lastName = "last name";

var person = {
    "first name": "Nicholas",
    [lastName]: "Zakas"
};

console.log(person["first name"]);      // "Nicholas"
console.log(person[lastName]);          // "Zakas"

// New standard functions
//

// Object.assign

// ES5
//
function mixin(receiver, supplier) {
    Object.keys(supplier).forEach(function(key) {
        receiver[key] = supplier[key];
    });

    return receiver;
}

function EventTarget() { /*...*/ }
EventTarget.prototype = {
    constructor: EventTarget,
    emit: function() { /*...*/ },
    on: function() { /*...*/ }
};

var myObject = {};
mixin(myObject, EventTarget.prototype);

myObject.emit("somethingChanged");

// ES6
//
function EventTarget() { /*...*/ }
EventTarget.prototype = {
    constructor: EventTarget,
    emit: function() { /*...*/ },
    on: function() { /*...*/ }
};

var myObject = {};
Object.assign(myObject, EventTarget.prototype);

myObject.emit("somethingChanged");

// multiple suppliers
//
var receiver = {};

Object.assign(receiver,
    {
        type: "js",
        name: "file.js"
    },
    {
        type: "css"
    }
);

console.log(receiver.type);     // "css"
console.log(receiver.name);     // "file.js"

// Duplicate properties
//

// ES5
var person = {
    name: "Nicholas",
    name: "Greg"        // syntax error in ES5 strict mode
};

// ES6
var person = {
    name: "Nicholas",
    name: "Greg"        // no error in ES6 strict mode
};

console.log(person.name);       // "Greg"

// Property enumeration order
//

// ES5
//
// depends on implementation


// ES6
//
var obj = {
    a: 1,
    0: 1,
    c: 1,
    2: 1,
    b: 1,
    1: 1
};

obj.d = 1;

console.log(Object.getOwnPropertyNames(obj).join(""));     // "012acbd"

// Prototypes
//

// ES5
//
// no standard way to change prototype after object is created

// ES6
//
let person = {
    getGreeting() {
        return "Hello";
    }
};

let dog = {
    getGreeting() {
        return "Woof";
    }
};

// prototype is person
let friend = Object.create(person);
console.log(friend.getGreeting());                      // "Hello"
console.log(Object.getPrototypeOf(friend) === person);  // true

// set prototype to dog
Object.setPrototypeOf(friend, dog);
console.log(friend.getGreeting());                      // "Woof"
console.log(Object.getPrototypeOf(friend) === dog);     // true

// Super
//

// ES5
let friend = {
    getGreeting() {
        return Object.getPrototypeOf(this).getGreeting.call(this) + ", hi!";
    }
};

// ES6
let friend = {
    getGreeting() {
        // Object.getPrototypeOf(this).getGreeting.call(this)
        return super.getGreeting() + ", hi!";
    }
};

// invalid outside of concise methods
//
let friend = {
    getGreeting: function() {
        // syntax error
        return super.getGreeting() + ", hi!";
    }
};


// multi level super calls
//

// ES5

// prototype is person
let friend = {
    getGreeting() {
        return Object.getPrototypeOf(this).getGreeting.call(this) + ", hi!";
    }
};
Object.setPrototypeOf(friend, person);


// prototype is friend
let relative = Object.create(friend);

console.log(person.getGreeting());                  // "Hello"
console.log(friend.getGreeting());                  // "Hello, hi!"
console.log(relative.getGreeting());                // error!

// ES6
let friend = {
    getGreeting() {
        return super.getGreeting() + ", hi!";
    }
};
Object.setPrototypeOf(friend, person);


// prototype is friend
let relative = Object.create(friend);

console.log(person.getGreeting());                  // "Hello"
console.log(friend.getGreeting());                  // "Hello, hi!"
console.log(relative.getGreeting());                // "Hello, hi!"


// Methods
//
// Methods are now formally defined and differ from functions. super can only
// be called on methods since they know what their [[HomeObject]] is.

let person = {
    // method
    getGreeting() {
        return "Hello";
    }
};

// not a method
function shareGreeting() {
    return "Hi!";
}

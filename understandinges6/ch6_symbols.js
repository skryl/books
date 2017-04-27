// Symbols
//
// Symbols are a new type of primitive value in JavaScript and are used to
// create properties that can’t be accessed without referencing the symbol.
//
// While not truly private, these properties are harder to accidentally change
// or overwrite and are therefore suitable for functionality that needs a level
// of protection from developers.
//
// You can provide descriptions for symbols that allow for easier identification
// of symbol values. There is a global symbol registry that allows you to use
// shared symbols in different parts of code by using the same description. In
// this way, the same symbol can be used for the same reason in multiple places.
//
// Methods like Object.keys() or Object.getOwnPropertyNames() don’t return
// symbols, so a new method called Object.getOwnPropertySymbols() was added in
// ECMAScript 6 to allow retrieval of symbol properties. You can still make
// changes to symbol properties by calling the Object.defineProperty() and
// Object.defineProperties() methods.
//
// Well-known symbols define previously internal-only functionality for standard
// objects and use globally-available symbol constants, such as the
// Symbol.hasInstance property. These symbols use the prefix Symbol. in the
// specification and allow developers to modify standard object behavior in a
// variety of ways.


let firstName = Symbol('description')
let lastName  = Symbol('description') // not the same symbol
let person = {}

person[firstName] = 'Alex'
console.log(person[firstName])
console.log(person[lastName]) // undefined
console.log(firstName === lastName) // false
console.log(typeof firstName) // symbol


// Using symbols
//

// use a computed object literal property
let person = {
    [firstName]: "Nicholas"
};

// make the property read only
Object.defineProperty(person, firstName, { writable: false });

let lastName = Symbol("last name");

Object.defineProperties(person, {
    [lastName]: {
        value: "Zakas",
        writable: false
    }
});

console.log(person[firstName]);     // "Nicholas"
console.log(person[lastName]);      // "Zakas"


// Sharing Symbols Globally
//
let uid = Symbol.for("uid");
let object = {};

object[uid] = "12345";

console.log(object[uid]);       // "12345"
console.log(uid);               // "Symbol(uid)"

let uid2 = Symbol.for("uid");

console.log(uid === uid2);      // true
console.log(object[uid2]);      // "12345"
console.log(uid2);              // "Symbol(uid)"


// Symbol Properties
//

let uid = Symbol.for("uid");
let object = {
    [uid]: "12345"
};

// getOwnPropertyNames() will not return symbol properties!
let symbols = Object.getOwnPropertySymbols(object);

console.log(symbols.length);        // 1
console.log(symbols[0]);            // "Symbol(uid)"
console.log(object[symbols[0]]);    // "12345"

// well known symbols

//...
Symbol.create
Symbol.hasInstance
Symbol.iterator
//...

// Symbol.hasInstance property
//
let obj = [];

obj instanceOf Array

// is the same as...

Array[Symbol.hasInstance](obj)

// redefining the instanceOf operator
//

function MyObject() {
    // ...
}

Object.defineProperty(MyObject, Symbol.hasInstance, {
    value: function(v) {
        return false;
    }
});

let obj = new MyObject();

console.log(obj instanceof MyObject); // false

// making objects concatable
//

let collection = {
    0: "Hello",
    1: "world",
    length: 2,
    [Symbol.isConcatSpreadable]: true
};

let messages = [ "Hi" ].concat(collection);

console.log(messages.length);    // 3
console.log(messages);           // ["Hi","Hello","world"]

// Building regexp-like objects
//

// effectively equivalent to /^.{10}$/
let hasLengthOf10 = {
    [Symbol.match]: function(value) {
        return value.length === 10 ? [value] : null;
    },
    [Symbol.replace]: function(value, replacement) {
        return value.length === 10 ? replacement : value;
    },
    [Symbol.search]: function(value) {
        return value.length === 10 ? 0 : -1;
    },
    [Symbol.split]: function(value) {
        return value.length === 10 ? ["", ""] : [value];
    }
};

let message1 = "Hello world",   // 11 characters
    message2 = "Hello John";    // 10 characters

let match1 = message1.match(hasLengthOf10),
    match2 = message2.match(hasLengthOf10);

console.log(match1);            // null
console.log(match2);            // ["Hello John"]

let replace1 = message1.replace(hasLengthOf10, "Howdy!"),
    replace2 = message2.replace(hasLengthOf10, "Howdy!");

console.log(replace1);          // "Hello world"
console.log(replace2);          // "Howdy!"

let search1 = message1.search(hasLengthOf10),
    search2 = message2.search(hasLengthOf10);

console.log(search1);           // -1
console.log(search2);           // 0

let split1 = message1.split(hasLengthOf10),
    split2 = message2.split(hasLengthOf10);

console.log(split1);            // ["Hello world"]
console.log(split2);            // ["", ""]

// overwriting object coercion behavior
//
function Temperature(degrees) {
    this.degrees = degrees;
}

Temperature.prototype[Symbol.toPrimitive] = function(hint) {

    switch (hint) {
        case "string":
            return this.degrees + "\u00b0"; // degrees symbol

        case "number":
            return this.degrees;

        case "default":
            return this.degrees + " degrees";
    }
};

let freezing = new Temperature(32);

console.log(freezing + "!");            // "32 degrees!"
console.log(freezing / 2);              // 16
console.log(String(freezing));          // "32째"

// Symbol.toStringTag
//
function Person(name) {
    this.name = name;
}

Person.prototype[Symbol.toStringTag] = "Person";

let me = new Person("Nicholas");

console.log(me.toString());                         // "[object Person]"
console.log(Object.prototype.toString.call(me));    // "[object Person]"

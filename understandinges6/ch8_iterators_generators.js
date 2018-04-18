// Summary
// Iterators are an important part of ECMAScript 6 and are at the root of
// several key language elements. On the surface, iterators provide a simple
// way to return a sequence of values using a simple API. However, there are
// far more complex ways to use iterators in ECMAScript 6.
//
// The Symbol.iterator symbol is used to define default iterators for objects.
// Both built-in objects and developer-defined objects can use this symbol to
// provide a method that returns an iterator. When Symbol.iterator is provided
// on an object, the object is considered an iterable.
//
// The for-of loop uses iterables to return a series of values in a loop. Using
// for-of is easier than iterating with a traditional for loop because you no
// longer need to track values and control when the loop ends. The for-of loop
// automatically reads all values from the iterator until there are no more,
// and then it exits.
//
// To make for-of easier to use, many values in ECMAScript 6 have default
// iterators. All the collection types–that is, arrays, maps, and sets–have
// iterators designed to make their contents easy to access. Strings also have
// a default iterator, which makes iterating over the characters of the string
// (rather than the code units) easy.
//
// The spread operator works with any iterable and makes converting iterables
// into arrays easy, too. The conversion works by reading values from an
// iterator and inserting them individually into an array.
//
// A generator is a special function that automatically creates an iterator
// when called. Generator definitions are indicated by a star (*) character and
// use of the yield keyword to indicate which value to return for each
// successive call to the next() method.
//
// Generator delegation encourages good encapsulation of iterator behavior by
// letting you reuse existing generators in new generators. You can use an
// existing generator inside another generator by calling yield * instead of
// yield. This process allows you to create an iterator that returns values
// from multiple iterators.
//
// Perhaps the most interesting and exciting aspect of generators and iterators
// is the possibility of creating cleaner-looking asynchronous code. Instead of
// needing to use callbacks everywhere, you can set up code that looks
// synchronous but in fact uses yield to wait for asynchronous operations to
// complete.

// ES5 (for loops)
//
var colors = ["red", "green", "blue"];

for (var i = 0, len = colors.length; i < len; i++) {
  console.log(colors[i]);
}

// ES5 Iterators

function createIterator(items) {

    var i = 0;

    return {
        next: function() {

            var done = (i >= items.length);
            var value = !done ? items[i++] : undefined;

            return {
                done: done,
                value: value
            };

        }
    };
}

var iterator = createIterator([1, 2, 3]);

console.log(iterator.next());           // "{ value: 1, done: false }"
console.log(iterator.next());           // "{ value: 2, done: false }"
console.log(iterator.next());           // "{ value: 3, done: false }"
console.log(iterator.next());           // "{ value: undefined, done: true }"

// for all further calls
console.log(iterator.next());           // "{ value: undefined, done: true }"


// ES6 Generators
//

function *createIterator() {
  yield 1;
  yield 2;
  yield 3;
}

let iterator = createIterator();

console.log(iterator.next().value);  // 1
console.log(iterator.next().value);  // 2
console.log(iterator.next().value);  // 3


// yield in loop
//
function *createIterator(items) {
    for (let i = 0; i < items.length; i++) {
        yield items[i];
    }
}

let iterator = createIterator([1, 2, 3]);

console.log(iterator.next());           // "{ value: 1, done: false }"
console.log(iterator.next());           // "{ value: 2, done: false }"
console.log(iterator.next());           // "{ value: 3, done: false }"
console.log(iterator.next());           // "{ value: undefined, done: true }"

// for all further calls
console.log(iterator.next());           // "{ value: undefined, done: true }"


// yield cannot cross function boundaries
//
function *createIterator(items) {
  items.forEach(function(item) {
    yield item + 1; // syntax error
  });
}

// generator function expression (not possible with arrow functions)
//
let createIterator = function *(items) {
    for (let i = 0; i < items.length; i++) {
        yield items[i];
    }
};

// object literal syntax
//
var o = {
    *createIterator(items) {
        for (let i = 0; i < items.length; i++) {
            yield items[i];
        }
    }
};
let iterator = o.createIterator([1, 2, 3]);

// iterables and for-of
//
let values = [1, 2, 3]; // iterable

for (let num of values) {
    console.log(num);
}

// what for-of actually does...
let iterator = values[Symbol.iterator]()
iterator.next()

// detecting if objects are iterable
function isIterable(object) {
  return typeof object[Symbol.iterator] === "function";
}

console.log(isIterable([1, 2, 3]));     // true
console.log(isIterable("Hello"));       // true
console.log(isIterable(new Map()));     // true
console.log(isIterable(new Set()));     // true
console.log(isIterable(new WeakMap())); // false
console.log(isIterable(new WeakSet())); // false

// creating iterables
let collection = {
  items: [],
  *[Symbol.iterator]() {
    for (let item of this.items) {
      yield item;
    }
  }
};

collection.items.push(1);
collection.items.push(2);
collection.items.push(3);

for (let x of collection) {
    console.log(x);
}

// built-in iterators
//

// entries()

let colors = [ "red", "green", "blue" ];
let tracking = new Set([1234, 5678, 9012]);
let data = new Map();

data.set("title", "Understanding ECMAScript 6");
data.set("format", "ebook");

for (let entry of colors.entries()) {
    console.log(entry);
}

for (let entry of tracking.entries()) {
    console.log(entry);
}

for (let entry of data.entries()) {
    console.log(entry);
}

// keys()

for (let key of colors.keys()) {
    console.log(key);
}

for (let key of tracking.keys()) {
    console.log(key);
}

for (let key of data.keys()) {
    console.log(key);
}


// values()

for (let value of colors.values()) {
    console.log(value);
}

for (let value of tracking.values()) {
    console.log(value);
}

for (let value of data.values()) {
    console.log(value);
}

// default iterators

// same as using colors.values()
for (let value of colors) {
    console.log(value);
}

// same as using tracking.values()
for (let num of tracking) {
    console.log(num);
}

// same as using data.entries()
for (let entry of data) {
    console.log(entry);
}

// same as using data.entries()
for (let [key, value] of data) {
    console.log(key + "=" + value);
}

// String Iterators
//

// supports unicode
//
var message = "A ð ®· B";

for (let c of message) {
    console.log(c);
}

// The Spread Operator (convert iterables to arrays)
//

let set1 = new Set([1, 2, 3, 3, 3, 4, 5]),
    array1 = [...set1];

console.log(array1);

let map2 = new Map([ ["name", "Nicholas"], ["age", 25]]),
    array2 = [...map2];

console.log(array2);

let smallNumbers = [1, 2, 3],
    bigNumbers = [100, 101, 102],
    allNumbers = [0, ...smallNumbers, ...bigNumbers];

console.log(allNumbers.length);     // 7
console.log(allNumbers);    // [0, 1, 2, 3, 100, 101, 102]

let str = "Alex",
    array3 = [...str];

console.log(array3);

// Iterator Arguments
//

function *createIterator() {
    let first = yield 1;
    let second = yield first + 2;       // 4 + 2
    yield second + 3;                   // 5 + 3
}

let iterator = createIterator();

console.log(iterator.next());  // "{ value: 1, done: false }"
console.log(iterator.next(4)); // "{ value: 6, done: false }"
console.log(iterator.next(5)); // "{ value: 8, done: false }"
console.log(iterator.next());  // "{ value: undefined, done: true }"


// return statements
function *createIterator() {
    yield 1;
    return;
    yield 2; // never called
    yield 3;
}

let iterator = createIterator();

console.log(iterator.next()); // "{ value: 1, done: false }"
console.log(iterator.next()); // "{ value: undefined, done: true }"


// Delegation to Generators
//

function *createNumberIterator() {
    yield 1;
    yield 2;
}

function *createColorIterator() {
    yield "red";
    yield "green";
}

function *createCombinedIterator() {
    yield *createNumberIterator();
    yield *createColorIterator();
    yield true;
}

var iterator = createCombinedIterator();

console.log(iterator.next());           // "{ value: 1, done: false }"
console.log(iterator.next());           // "{ value: 2, done: false }"
console.log(iterator.next());           // "{ value: "red", done: false }"
console.log(iterator.next());           // "{ value: "green", done: false }"
console.log(iterator.next());           // "{ value: true, done: false }"
console.log(iterator.next());           // "{ value: undefined, done: true }"

// using a generator's return value

function *createNumberIterator() {
    yield 1;
    yield 2;
    return 3;
}

function *createRepeatingIterator(count) {
    for (let i=0; i < count; i++) {
        yield "repeat";
    }
}

function *createCombinedIterator() {
    let result = yield *createNumberIterator();
    yield *createRepeatingIterator(result);
}

var iterator = createCombinedIterator();

console.log(iterator.next());  // "{ value: 1, done: false }"
console.log(iterator.next());  // "{ value: 2, done: false }"
console.log(iterator.next());  // "{ value: "repeat", done: false }"
console.log(iterator.next());  // "{ value: "repeat", done: false }"
console.log(iterator.next());  // "{ value: "repeat", done: false }"
console.log(iterator.next());  // "{ value: undefined, done: true }"

// Asynchronous Programming
//

// ES5 (traditional callbacks)
let fs = require("fs");

fs.readFile("config.json", function(err, contents) {
    if (err) {
        throw err;
    }

    doSomethingWith(contents);
    console.log("Done");
});

// a task runner
//
function run(taskDef) {

    // create the iterator, make available elsewhere
    let task = taskDef()

    // start the task
    let result = task.next()

    // recursive function to keep calling next()
    function step() {

        // if there's more to do
        if (!result.done) {
            if (typeof result.value === 'function') {
                result.value(function(err, data) {
                    if (err) {
                      result = task.throw(err);
                      return;
                    }

                    result = task.next(data);
                    step();
                })
            } else {
                result = task.next(result.value)
                step()
            }
        }
    }

    // start the process
    step()
}

run(function*(){
  console.log(1)
  yield
  console.log(2)
  yield
  console.log(3)
})


run(function*() {
  let value = yield 1;
  console.log(value)

  value = yield value + 3;
  console.log(value)
})



// Now with some async work...
//
function fetchData() {
    return function(callback) {
        setTimeout(function() {
            callback(null, "Hi!");
        }, 50);
    };
}

run(function*() {
  let data1 = yield fetchData();
  console.log(data1)
  let data2 = yield fetchData();
  console.log(data2)
  console.log(yield)
  console.log(yield)
})


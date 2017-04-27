// Sets and Maps
//
// ECMAScript 6 formally introduces sets and maps into JavaScript. Prior to
// this, developers frequently used objects to mimic both sets and maps, often
// running into problems due to the limitations associated with object
// properties.
//
// Sets are ordered lists of unique values. Values are not coerced to determine
// equivalence. Sets automatically remove duplicate values, so you can use a
// set to filter an array for duplicates and return the result. Sets aren’t
// subclasses of arrays, so you cannot randomly access a set’s values. Instead,
// you can use the has() method to determine if a value is contained in the set
// and the size property to inspect the number of values in the set. The Set
// type also has a forEach() method to process each set value.
//
// Weak sets are special sets that can contain only objects. The objects are
// stored with weak references, meaning that an item in a weak set will not
// block garbage collection if that item is the only remaining reference to an
// object. Weak set contents can’t be inspected due to the complexities of
// memory management, so it’s best to use weak sets only for tracking objects
// that need to be grouped together.
//
// Maps are ordered key-value pairs where the key can be any data type. Similar
// to sets, keys are not coerced to determine equivalence, which means you can
// have a numeric key 5 and a string "5" as two separate keys. A value of any
// data type can be associated with a key using the set() method, and that
// value can later be retrieved by using the get() method. Maps also have a
// size property and a forEach() method to allow for easier item access.
//
// Weak maps are a special type of map that can only have object keys. As with
// weak sets, an object key reference is weak and doesn’t prevent garbage
// collection when it’s the only remaining reference to an object. When a key
// is garbage collected, the value associated with the key is also removed from
// the weak map. This memory management aspect makes weak maps uniquely suited
// for correlating additional information with objects whose lifecycles are
// managed outside of the code accessing them.


// ES5
//
// object properties were used to mimic sets and maps

let set = Object.create(null); // null prototype means there are no extra properties

set.foo = true;

if (set.foo) {
    // do something
}

// coercion issues

map[5] = "foo";

console.log(map["5"]);      // "foo"

let key1 = {},
    key2 = {};

map[key1] = "foo";

console.log(map[key2]);     // "foo"

// Sets
//

let set = new Set();
let key1 = {}
let key2 = {}

set.add(5);
set.add(key1);

console.log(set.size);       // 2
console.log(set.has(5));     // true
console.log(set.has('5'));   // false
console.log(set.has(key1));  // true
console.log(set.has(key2));  // false

// converting arrays
//
let set = new Set([1, 2, 3, 4, 5, 5, 5, 5]);

console.log(set.size);    // 5

set.delete(1)

console.log(set.size);    // 4

set.clear()

console.log(set.size);    // 0


// forEach
//
let set = new Set([1, 2]);

set.forEach((value, key, ownerSet) => {
    console.log(key + " " + value);
    console.log(ownerSet === set);
});

// converstion to Array
//
let set = new Set([1, 2, 3, 3, 3, 4, 5]),
    array = [...set];

console.log(array); // [1,2,3,4,5]

// cool!
function eliminateDuplicates(items) {
    return [...new Set(items)];
}

let numbers = [1, 2, 3, 3, 3, 4, 5],
    noDuplicates = eliminateDuplicates(numbers);

console.log(noDuplicates);      // [1,2,3,4,5]

// Weak Sets
//

// regular sets keep objects from being garbage collected
//
let set = new Set(),
    key = {};

set.add(key);
console.log(set.size);      // 1

// eliminate original reference
key = null;

console.log(set.size);      // 1

// get the original reference back
key = [...set][0];


// WeakSet to the rescue!
//
let set = new WeakSet(),
    key = {};

set.add(key);
console.log(set.size);      // 1

// eliminate original reference
key = null;

console.log(set.size);      // 0

// Maps
//

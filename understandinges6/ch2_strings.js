// Strings
//
// Full Unicode support allows JavaScript to deal with UTF-16 characters in
// logical ways. The ability to transfer between code point and character via
// codePointAt() and String.fromCodePoint() is an important step for string
// manipulation. The addition of the regular expression u flag makes it
// possible to operate on code points instead of 16-bit characters, and the
// normalize() method allows for more appropriate string comparisons.
//
// ECMAScript 6 also added new methods for working with strings, allowing you
// to more easily identify a substring regardless of its position in the parent
// string. More functionality was added to regular expressions, too.
//
// Template literals are an important addition to ECMAScript 6 that allows you
// to create domain-specific languages (DSLs) to make creating strings easier.
// The ability to embed variables directly into template literals means that
// developers have a safer tool than string concatenation for composing long
// strings with variables.
//
// Built-in support for multiline strings also makes template literals a useful
// upgrade over normal JavaScript strings, which have never had this ability.
// Despite allowing newlines directly inside the template literal, you can
// still use \n and other character escape sequences.
//
// Template tags are the most important part of this feature for creating DSLs.
// Tags are functions that receive the pieces of the template literal as
// arguments. You can then use that data to return an appropriate string value.
// The data provided includes literals, their raw equivalents, and any
// substitution values. These pieces of information can then be used to
// determine the correct output for the tag.


// New standard library functions yay!
var msg = "Hello world!";

console.log(msg.startsWith("Hello"));  // true
console.log(msg.endsWith("!"));        // true
console.log(msg.includes("o"));        // true

console.log(msg.startsWith("o"));      // false
console.log(msg.endsWith("world!"));   // true
console.log(msg.includes("x"));        // false

console.log(msg.startsWith("o", 4));   // true
console.log(msg.endsWith("o", 8));     // true
console.log(msg.includes("o", 8));     // false

console.log("x".repeat(3));         // "xxx"
console.log("hello".repeat(2));     // "hellohello"
console.log("abc".repeat(4));       // "abcabcabcabc"

// Template Literals

let substr = 'brave new';
let message = `\`Hello\` ${sbstr} world!`;

console.log(message);               // "`Hello` world!"
console.log(typeof message);        // "string"
console.log(message.length);        // 14

// Multiline Strings
//

// ES5
var mes1 = "Multiline \n\
string";

console.log(mes1); // "Multiline
                   //  string"

// ES6
let mes2 = `Multiline
string`;

console.log(mes2); // "Multiline
                   //  string"

// Tagged Templates
//
function passthru(literals, ...substitutions) {
    let result = "";

    // run the loop only for the substitution count
    for (let i = 0; i < substitutions.length; i++) {
        result += literals[i];
        result += substitutions[i];
    }

    // add the last literal
    result += literals[literals.length - 1];

    return result;
}

let count = 10,
    price = 0.25,
    mes3  = passthru`${count} items cost $${(count * price).toFixed(2)}.`;

console.log(mes3);       // "10 items cost $2.50."

// Raw String Values
//
let message1 = `Multiline\nstring`,
    message2 = String.raw`Multiline\nstring`;

console.log(message1);  // "Multiline
                        //  string"
console.log(message2);  // "Multiline\\nstring"

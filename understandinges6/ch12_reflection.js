// Prior to ECMAScript 6, certain objects (such as arrays) displayed
// nonstandard behavior that developers couldn’t replicate. Proxies change
// that. They let you define your own nonstandard behavior for several
// low-level JavaScript operations, so you can replicate all behaviors of
// built-in JavaScript objects through proxy traps. These traps are called
// behind the scenes when various operations take place, like a use of the in
// operator.
//
// A reflection API was also introduced in ECMAScript 6 to allow developers to
// implement the default behavior for each proxy trap. Each proxy trap has a
// corresponding method of the same name on the Reflect object, another
// ECMAScript 6 addition. Using a combination of proxy traps and reflection API
// methods, it’s possible to filter some operations to behave differently only
// in certain conditions while defaulting to the built-in behavior.
//
// Revocable proxies are a special proxies that can be effectively disabled by
// using a revoke() function. The revoke() function terminates all
// functionality on the proxy, so any attempt to interact with the proxy’s
// properties throws an error after revoke() is called. Revocable proxies are
// important for application security where third-party developers may need
// access to certain objects for a specified amount of time.
//
// While using proxies directly is the most powerful use case, you can also use
// a proxy as the prototype for another object. In that case, you are severely
// limited in the number of proxy traps you can effectively use. Only the get,
// set, and has proxy traps will ever be called on a proxy when it’s used as a
// prototype, making the set of use cases much smaller.

// Simple Proxy
//
let target = {};

let proxy = new Proxy(target, {});

proxy.name = "proxy";
console.log(proxy.name);        // "proxy"
console.log(target.name);       // "proxy"

target.name = "target";
console.log(proxy.name);        // "target"
console.log(target.name);       // "target"


// Setting Traps
//
let target = {
    name: "target"
};

let proxy = new Proxy(target, {
    set(trapTarget, key, value, receiver) {

        // ignore existing properties so as not to affect them
        if (!trapTarget.hasOwnProperty(key)) {
            if (isNaN(value)) {
                throw new TypeError("Property must be a number.");
            }
        }

        // add the property
        return Reflect.set(trapTarget, key, value, receiver);
    }
});

// adding a new property
proxy.count = 1;
console.log(proxy.count);       // 1
console.log(target.count);      // 1

// you can assign to name because it exists on target already
proxy.name = "proxy";
console.log(proxy.name);        // "proxy"
console.log(target.name);       // "proxy"

// throws an error
proxy.anotherName = "proxy";

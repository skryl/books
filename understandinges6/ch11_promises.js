// Promises are designed to improve asynchronous programming in JavaScript by
// giving you more control and composability over asynchronous operations than
// events and callbacks can. Promises schedule jobs to be added to the
// JavaScript engine’s job queue for execution later, while a second job queue
// tracks promise fulfillment and rejection handlers to ensure proper
// execution.
//
// Promises have three states: pending, fulfilled, and rejected. A promise
// starts in a pending state and becomes fulfilled on a successful execution or
// rejected on a failure. In either case, handlers can be added to indicate
// when a promise is settled. The then() method allows you to assign a
// fulfillment and rejection handler and the catch() method allows you to
// assign only a rejection handler.
//
// You can chain promises together in a variety of ways and pass information
// between them. Each call to then() creates and returns a new promise that is
// resolved when the previous one is resolved. Such chains can be used to
// trigger responses to a series of asynchronous events. You can also use
// Promise.race() and Promise.all() to monitor the progress of multiple
// promises and respond accordingly.
//
// Asynchronous task running is easier when you combine generators and
// promises, as promises give a common interface that asynchronous operations
// can return. You can then use generators and the yield operator to wait for
// asynchronous responses and respond appropriately.
//
// Most new web APIs are being built on top of promises, and you can expect
// many more to follow suit in the future.

// Async Patterns
//

// 1. Event Subscribers
//
let button = document.getElementById("my-btn");
button.onclick = function(event) {
    console.log("Clicked");
}

// 2. Callbacks
//
readFile("example.txt", function(err, contents) {
  if (err) {
    throw err;
  }

  console.log(contents);
});
console.log("Hi!");


// serialized callbacks (getting ugly)
//
readFile("example.txt", function(err, contents) {
    if (err) {
        throw err;
    }

    writeFile("example.txt", function(err) {
        if (err) {
            throw err;
        }

        console.log("File was written!");
    });
});


// Promises
oromise.then(function(value) {
    console.log('resolved'); // does not run
}, function(value) {
    console.log(value);      // 42
});
//
let promise = readFile("example.txt");

promise.then(function(contents) {
    // fulfillment
    console.log(contents);
}, function(err) {
    // rejection
    console.error(err.message);
});

promise.then(function(contents) {
    // fulfillment
    console.log(contents);
});

promise.then(null, function(err) {
    // rejection
    console.error(err.message);
});


// only responding to rejection
//

promise.catch(function(err) {
    // rejection
    console.error(err.message);
});

// is the same as:

promise.then(null, function(err) {
    // rejection
    console.error(err.message);
});


// Building a Promise
//
let fs = require("fs");

function readFile(filename) {
    return new Promise(function(resolve, reject) {

        // trigger the asynchronous operation
        fs.readFile(filename, { encoding: "utf8" }, function(err, contents) {

            // check for errors
            if (err) {
                reject(err);
                return;
            }

            // the read succeeded
            resolve(contents);

        });
    });
}

let promise = readFile("example.txt");

// listen for both fulfillment and rejection
promise.then(function(contents) {
    // fulfillment
    console.log(contents);
}, function(err) {
    // rejection
    console.error(err.message);
});


// Sleepy time
//
function sleepy(millis) {
    return new Promise(function(resolve, reject) {
      setTimeout(function(){
        console.log('Awake!')
        resolve()
      }, millis)
    });
}

let promise3 = sleepy(5000);

promise3.then(function(contents) {
  console.log('Done!')
})

// Resolved promises
//
let promise = Promise.resolve(42);

promise.then(function(value) {
    console.log(value);         // 42
}, function(value) {
    console.log('rejected');    // does not run
});


// Rejected promise
//
let promise = Promise.reject(42);

promise.then(function(value) {
    console.log('resolved'); // does not run
}, function(value) {
    console.log(value);      // 42
});


// Errors inside promises
//

let promise = new Promise(function(resolve, reject) {
    throw new Error("Explosion!");
});

promise.catch(function(error) {
    console.log(error.message);     // "Explosion!"
});


// Chaining
//
let p1 = new Promise(function(resolve, reject) {
    resolve(42);
});

p1.then(function(value) {
    console.log(value);
}).then(function() {
    console.log("Finished");
});


// Returning Values
//
let p1 = new Promise(function(resolve, reject) {
    resolve(42);
});

p1.then(function(value) {
    console.log(value);         // "42"
    return value + 1;
}).then(function(value) {
    console.log(value);         // "43"
});


// Waiting on all promises to settle
//
let p1 = new Promise(function(resolve, reject) {
    resolve(42);
});

let p2 = new Promise(function(resolve, reject) {
    resolve(43);
});

let p3 = new Promise(function(resolve, reject) {
    resolve(44);
});

let p4 = Promise.all([p1, p2, p3]);

p4.then(function(value) {
    console.log(Array.isArray(value));  // true
    console.log(value[0]);              // 42
    console.log(value[1]);              // 43
    console.log(value[2]);              // 44
});


// in case of rejection...
//
let p1 = new Promise(function(resolve, reject) {
    resolve(42);
});

let p2 = new Promise(function(resolve, reject) {
    reject(43);
});

let p3 = new Promise(function(resolve, reject) {
    resolve(44);
});

let p4 = Promise.all([p1, p2, p3]);

p4.catch(function(value) {
    console.log(Array.isArray(value))   // false
    console.log(value);                 // 43
});


// Waiting on the first promise to settle
//

let p4 = Promise.race([p1, p2, p3]);

p4.then(function(value) {
    console.log(value);  // 42
});

// Extending Promises
//

class MyPromise extends Promise {

    // use default constructor

    success(resolve, reject) {
        return this.then(resolve, reject);
    }

    failure(reject) {
        return this.catch(reject);
    }

}

let promise = new MyPromise(function(resolve, reject) {
    resolve(42);
});

promise.success(function(value) {
    console.log(value);             // 42
}).failure(function(value) {
    console.log(value);
});


// Async Task Running using Promises
//
function run(taskDef) {

    // create the iterator
    let task = taskDef();

    // start the task
    let result = task.next();

    // recursive function to iterate through
    (function step() {

        // if there's more to do
        if (!result.done) {

            // resolve to a promise to make it easy
            let promise = Promise.resolve(result.value);
            promise.then(function(value) {
                result = task.next(value);
                step();
            }).catch(function(error) {
                result = task.throw(error);
                step();
            });
        }
    }());
}

// Define task

function readFile(filename) {
    return new Promise(function(resolve, reject) {
        fs.readFile(filename, function(err, contents) {
            if (err) {
                reject(err);
            } else {
                resolve(contents);
            }
        });
    });
}

// Run task

run(function*() {
    let contents = yield readFile("config.json");
    doSomethingWith(contents);
    console.log("Done");
});


// Future syntax with async/await
//
(async function() {
    let contents = await readFile("config.json");
    doSomethingWith(contents);
    console.log("Done");
});

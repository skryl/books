// == Functions ==

func sayHelloWorld() -> String {
    return "hello, world"
}

func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}

greet("Bob", "Tuesday")

// void functions

func printHello() {
    println("Hello")
}

var hello:Void = printHello()

// external parameter names

func someFunction(externalParameterName localParameterName: Int) -> Int {
    return localParameterName
}
someFunction(externalParameterName: 3)


func containsCharacter(#string: String, #characterToFind: Character) -> Bool {
    for character in string {
        if character == characterToFind {
            return true
        }
    }
    return false
}
let containsAVee = containsCharacter(string: "aardvark", characterToFind: "v")

// default parameters

func join(string s1: String, toString s2: String, withJoiner joiner: String = " ") -> String {
    return s1 + joiner + s2
}

join(string: "hello", toString: "world")

func join2(s1: String, s2: String, joiner: String = " ") -> String {
    return s1 + joiner + s2
}

join2("hello", "world", joiner: "-")

// func join3(s1: String, s2: String, _ joiner: String = " ") -> String {
//     return s1 + joiner + s2
// }
//
// join2("hello", "world", "-")

// multiple return values

func getGasPrices() -> (Double, Double, Double) {
    return (3.59, 3.69, 3.79)
}
getGasPrices()

// variadics

func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

sumOf()
sumOf(42, 597, 12)

// variable parameters

func alignRight(var string: String, count: Int, pad: Character) -> String {
    let amountToPad = count - countElements(string)
    for _ in 1...amountToPad {
        string = String(pad) + string
    }
    return string
}

alignRight("hello", 10, "-")

// inout parameters

var s = "abc"
func modString(var str: String) {
    str += "d"
}
modString(s)
println(s)

// force string to be passed by ref

func modString2(inout str: String) {
    str += "d"
}
modString2(&s)
println(s)

func swapTwoInts(inout a: Int, inout b: Int) {
    let temp = a
    a = b
    b = temp
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
println("someInt: \(someInt), anotherInt: \(anotherInt)")


// nested functions

func makeIncrementer() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}

var increment = makeIncrementer()
increment(7)

// function arguments

func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}

func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    println("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5)

func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, lessThanTen)

// function return types

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)

while currentValue != 0 {
    println("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}

// == Closures and Lambdas ==

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

// var reversed = sort(names, backwards)

// var reversed = sort(names, { (s1: String, s2: String) -> Bool in return s1 > s2})

// var reversed = sort(names, { s1, s2 in return s1 > s2 })

// var reversed = sort(names, { s1, s2 in s1 > s2 })

// var reversed = sort(names, { $0 > $1 })

// var reversed = sort(names, >)

numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

numbers.map({ number in 3 * number })

// trailing closures

// var reversed = sort(names) { $0 > $1 }

let digitNames = [ 0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine" ]

let myNumbers = [16, 58, 510]

let strings = numbers.map {
    (var number) -> String in
    var output = ""

    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}


// function types

var mathFunction: (Int, Int) -> Int = addTwoInts
let anotherMathFunction = addTwoInts

addTwoInts(2, 3)
mathFunction(2, 3)
anotherMathFunction(2, 3)

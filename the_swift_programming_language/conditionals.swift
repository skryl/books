// == Conditionals ==

let myBool = true

if myBool {
    println("true")
} else {
    println("false")
}

myBool ? 1 : 2

let temp = 90
if temp <= 32 {
    println("damn cold")
} else if temp >= 86 {
    println("really warm")
} else {
    println("not that cold")
}

let myChar: Character = "e"

switch myChar {
    case "a", "e", "i", "o", "u":
        println("vowel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
        println("consonant")
    default:
        println("neither")
}

let numericCount = 3_000_000_000
var naturalCount: String

switch numericCount {
case 0:
    naturalCount = "no"
case 1...3:
    naturalCount = "a few"
case 4...9:
    naturalCount = "several"
case 10...99:
    naturalCount = "tens of"
case 100...999:
    naturalCount = "hunderds of"
case 1000...999_999:
    naturalCount = "thousands of"
default:
    naturalCount = "millions and millions of"
}

let somePoint = (1,1)
switch somePoint {
case (0, 0):
    println("(0, 0) is at the origin")
case (_, 0):
    println("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    println("(\(somePoint.0), 0) is on the y-axis")
case (-2...2, -2...2):
    println("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    println("uh oh!")
}

let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    println("on the x-axis with an x value of \(x)")
case (0, let y):
    println("on the x-axis with an x value of \(y)")
case let (x, y):
    println("somewhere else at (\(x), \(y))")
}

let vegetable = "red pepper"
switch vegetable {
    case "celery":
        let comment = "Add some raisins"
    case "cucumber", "watercress":
        let comment = "That would make a good sandwitch"
    case let x where x.hasSuffix("pepper"):
        let comment = "Is it a spicy \(x)?"
    default:
        let comment = "Everything is good in soup"
}

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    println("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    println("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    println("(\(x), \(y)) is just some arbitrary point")
}

println(teamScore)

// conditional must test Boolean

// if teamScore { println('true') }

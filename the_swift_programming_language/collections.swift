// == Collections ==

// arrays

var arr = Array<Int>()
var emptyArr = [Int]()
// emptyArr[0] = 1

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList.isEmpty
shoppingList.append("Flour")
shoppingList += ["Baking Soda", "Cheese"]
println(shoppingList)

var firstItem = shoppingList[0]
shoppingList[1] = "bottle of water"
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList.insert("Maple Syrup", atIndex: 0)
shoppingList.removeAtIndex(0)
shoppingList.removeLast()

var someInts = [Int]()
someInts.append(1)
someInts = []

var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
var anotherThreeDoubles = Array(count: 3, repeatedValue: 0.0)
var sixDoubles = threeDoubles + anotherThreeDoubles


// dictionaries

var airports: Dictionary<String, String> = ["TYO": "Tokyo", "DUB": "Dublin"]
airports["LHR"] = "London"

if let airportName = airports["DUB"] {
    println("The name of the airport is \(airportName).")
} else {
    println("That airport is not in the airports dictionary.")
}

airports["APL"] = "Apple International"
airports["APL"] = nil

for (airportCode, airportName) in airports {
    println("\(airportCode): \(airportName)")
}

for code in airports.keys {
    println("\(code)")
}

var emptyDict = Dictionary<Int, String>()
emptyDict[0] = "blah"
emptyDict = [:]

var anotherEmptyDict = [String:Float]()
var occupations = ["Malcolm": "Captain", "Kaylee": "Mechanic", ]


// tuples

let http404Error = ("404", "Page not found")
let (statusCode, statusMessage) = http404Error
let (justTheStatusCode, _) = http404Error
http404Error.0
http404Error.1

let http200Status = (statusCode: 200, description: "OK")
http200Status.statusCode
http200Status.description

let (x, y) = (1, 2)

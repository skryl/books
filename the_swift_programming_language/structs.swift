// == Structs ==

// structs are always passed by value (copied)

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

// structs have default property initializers

let threeOfSpades = Card(rank:.Three, suit: .Spades)
threeOfSpades.simpleDescription()

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)

rangeOfThreeItems.firstValue = 6

// length cannot be changed after initialization
// rangeOfThreeItems.length = 4

// constant struct instances cannot be modified

let anotherRangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)

// anotherRangeOfThreeItems.firstValue = 6


// structs cannot modify their own properties unless 'mutating' is used

struct APoint {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var point2 = APoint(x: 1.0, y: 1.0)
point2.moveByX(2.0, y: 3.0)
println("The point is now at (\(point2.x), \(point2.y))")

// cannot mutate constant struct
let aConstantPoint = APoint(x: 1.0, y: 1.0)
// aConstantPoint.moveByX(1.0, y: 1.0)

// == Loops ==

let scores = [75, 43, 103, 87, 12]

var teamScore = 0

for score in scores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

let interestingNumbers = [
    "Prime": [2,3,5,7,11,13],
    "Fibonacci": [1,1,2,3,5,8],
    "Square": [1,4,9,16,25]
]

var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}

for index in 1...5 {
    println("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1

for _ in 1...power {
    answer *= base
}

println("\(base) to the power of \(power) is \(answer)")

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    println("\(animalName)s have \(legCount) legs")
}

for character in "Hello" {
    println(character)
}

for var index = 0; index < 3; ++index {
    println("index is \(index)")
}

var n = 2
while n < 100 {
    n = n * 2
}

var m = 2
do {
    m = m * 2
} while m < 100

var count = 0
for i in 0...3 {
    count += i;
}

var count2 = 0
for var i = 0; i < 3; ++i {
    count2 += 1
}

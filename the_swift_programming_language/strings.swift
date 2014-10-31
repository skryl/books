// == Strings ==

let emptyString = String()
let emptyLiteral = ""
let apples = 3
let oranges = 5
let summary = "I have \(apples + oranges) fruit"
// let dollarSign = "\x24"
// let blackHeart = "\u2665"

if emptyString.isEmpty {
    println("nothing here")
}

for char in "Dog!" {
    println(char)
}

let yetSign: Character = "¥"
countElements(summary)

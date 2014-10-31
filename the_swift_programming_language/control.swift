// == Control Transfer ==

// continue

let input = "great minds think alike"
var output = ""

var puzzleOutput = ""
for myChar in input {
    switch myChar {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        output += String(myChar)
    }
}

println(output)

// break


for myChar in input {
    switch myChar {
    case "a", "e", "i", "o", "u", " ":
        break
    default:
        output += String(myChar)
    }
}

println(output)

switch 10 {
case 1, 2, 3:
    println("1, 2, 3")
default:
    break
}

// fallthrough

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is "
switch integerToDescribe {
case 2, 3, 5, 7 , 9, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
println(description)

// labels


var diceRoll = 5

gameLoop: while true {
    switch diceRoll {
    case 1, 2, 3:
        println("win")
        break gameLoop
    case 4, 5, 6:
        println("lose")
        break gameLoop
    default:
        break gameLoop
    }
}

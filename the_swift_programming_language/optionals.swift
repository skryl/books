// == Optionals ==

let possibleNumber = "123"
let convertedNumber = possibleNumber.toInt()

// forced unwrapping
convertedNumber!

if convertedNumber != nil {
    println("\(possibleNumber) has an integer value of \(convertedNumber!)")
} else {
    println("\(possibleNumber) could not be converted to an integer")
}

// optional binding

var optionalName: String? = "John"

if let name = optionalName {
    println("Hello, \(name)")
}

// implicitly unwrapped optionals

let possibleString: String? = "an optional string"
let assumedString: String! = "an assumed string"

println(possibleString!)
println(assumedString)

// chaining

class Person {
  var residence: Residence?
}

class Residence {
  var rooms = [Room]()
  var numberOfRooms: Int {
    return rooms.count
  }
  subscript(i: Int) -> Room {
    return rooms[i]
  }
  func printNumberOfRooms() {
    println("The number of rooms is \(numberOfRooms)")
  }
  var address: Address?
}

class Room {
  let name: String
  init(name: String) { self.name = name }
}

class Address {
  var buildingName: String?
  var buildingNumber: String?
  var street: String?

  func buildingIdentifier() -> String? {
    if buildingName != nil {
      return buildingName
    } else if buildingNumber != nil {
      return buildingNumber
    } else {
      return nil
    }
  }
}

let john = Person()
let roomCount = john.residence!.numberOfRooms
let roomCount = john.residence?.numberOfRooms

if let roomCount = john.residence?.numberOfRooms {
  println("John's residence has \(roomCount) room(s).")
} else {
  println("Unable to retrieve the number of rooms.")
}

// Void return type is turned into Void?
if john.residence?.printNumberOfRooms() != nil {
  println("John's residence has room(s).")
} else {
  println("Unable to retrieve the number of rooms.")
}

john.residence = Residence()
var someAddress = Address()

if (john.residence?.address = someAddress) != nil {
  println("It was possible to set an address.")
} else {
  println("It was not possible to set an address.")
}

var johnsHouse = Residence()
johnsHouse.rooms += Room(name: "Living Room")
johnsHouse.rooms += Room(name: "Kitchen")
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
  println("The first room name is \(firstRoomName).")
} else {
  println("Unable to retrieve the first room name.")
}

// multiple levels

if let johnsStreet = john.residence?.address?.street {
  println("John's street name is \(johnsStreet).")
} else {
  println("Unable to retrieve the address.")
}

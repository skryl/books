// == Protocols and Extensions ==

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

// all types are equivalent and can adopt a protocol

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription  += " Now 100% adjusted."
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust () {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

7.simpleDescription

let protocolValue: ExampleProtocol = a
protocolValue.simpleDescription
// protocolValue.anotherProperty ERROR!

// properties

protocol FullyNamed {
  var fullName: String { get }
}

struct Person: FullyNamed {
  var fullName: String
}

let john = Person(fullName: "Johnny Appleseed")

// methods

protocol RandomNumberGenerator {
  func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
  var lastRandom = 42.0
  let m = 139968.0
  let a = 3877.0
  let c = 29573.0
  func random() -> Double {
    lastRandom = ((lastRandom * a + c) % m)
    return lastRandom / m
  }
}

let generator = LinearCongruentialGenerator()
generator.random()

class Dice {
  let sides: Int
  let generator: RandomNumberGenerator
  init(sides: Int, generator: RandomNumberGenerator) {
    self.sides = sides
    self.generator = generator
  }
  func roll() -> Int {
    return Int(generator.random() * Double(sides)) + 1
  }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
d6.roll()

// protocol conformance using extensions

protocol TextRepresentable {
  func asText() -> String
}

extension Dice: TextRepresentable {
  func asText() -> String {
    return "A \(sides)-sided dice"
  }
}


let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
println(d12.asText())

// protocol adoption with an extension

struct Hamster {
  var name: String
  func asText() -> String {
    return "A hamster named \(name)"
  }
}

extension Hamster: TextRepresentable {}
let simonTheHamster = Hamster(name: "Simon")
let somethingTexty: TextRepresentable = simonTheHamster
println(somethingTexty.asText())

// inheritance

protocol PrettyTextRepresentable: TextRepresentable {
  func asPrettyText() -> String
}

extension Hamster: PrettyTextRepresentable {
  func asPrettyText() -> String {
    return "*&^$#@ \(asText()) @#$$%^&*"
  }
}

// compositions

protocol Named {
  var name: String { get }
}

protocol Aged {
  var age: Int { get }
}

struct Person: Named, Aged {
  var name: String
  var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
  println("Happy Birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayPerson = Person(name: "Malcom", age: 21)
wishHappyBirthday(birthdayPerson)

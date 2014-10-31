class Person {
  let name: String
  var apartment: Apartment?

  init(name: String) {
    self.name = name
    println("\(name) is being initialized")
  }
  deinit {
    println("\(name) is being de-initialized")
  }
}

var ref1: Person?
var ref2: Person?
var ref3: Person?

ref1 = Person(name: "Johnny Appleseed")
ref2 = ref1
ref3 = ref1

ref1 = nil
ref2 = nil
ref3 = nil /* de-initialized */

// strong cycles

class Apartment {
  let number: Int
  var tenant: Person?

  init(number: Int) {
    self.number = number
    println("Apartment #\(number) is being initialized")
  }
  deinit {
    println("Apartment #\(number) is being de-initialized")
  }
}

var john: Person?
var number73: Apartment?

john = Person(name: "Johnny Appleseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

john = nil
number73 = nil

// weak references

class Apartment {
  let number: Int
  weak var tenant: Person?

  init(number: Int) {
    self.number = number
    println("Apartment #\(number) is being initialized")
  }
  deinit {
    println("Apartment #\(number) is being de-initialized")
  }
}

var john: Person?
var number73: Apartment?

john = Person(name: "Johnny Appleseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

// unowned references

class Customer {
  let name: String
  var card: CreditCard?
  init(name: String) {
    self.name = name
  }
  deinit {
    println("\(name) is being de-initialized")
  }
}

class CreditCard {
  let number: Int
  unowned let customer: Customer

  init(number: Int, customer: Customer) {
    self.number = number
    self.customer = customer
  }
  deinit {
    println("Card #\(number) is being de-initialized")
  }
}

var john: Customer?
john = Customer(name: "Johnny Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)

john = nil

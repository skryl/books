// == Classes ==

class Shape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = Shape(name: "pentagon")
shape.numberOfSides = 5
var shapeDescription = shape.simpleDescription()

class Square: Shape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

class EquilateralTriangle: Shape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }

    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0

        }
        }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)"
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")

triangle.perimeter
triangle.perimeter = 9.9
triangle.sideLength

// parameter names when calling

class Counter2 {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes times: Int) {
        count += amount * times
    }
}

var myCounter = Counter2()
myCounter.incrementBy(3, numberOfTimes: 3)

// lazy properties

//class DataManager {
//    var name = String()
//    @lazy var data = initComplexObject()
//}
//
//var d = DataManager()
//d.name = "manager"

// data is initialized when first used
// d.data

// computed properties

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
        //set {
        //    origin.x = newValue.x - (size.width / 2)
        //    origin.y = newValue.y - (size.height / 2)
        //}
    }
}

var square = Rect(origin: Point(), size: Size(width: 10.0, height: 10.0))

let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)

// read-only computed properties

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
fourByFiveByTwo.volume

// property observers

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            println("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                println("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360

// type properties

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 40 + 2
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 40 + 2
    }
}

// does not support stored properties

class SomeClass {
    // static var storedTypeProperty = "Some value"
    class var computedTypeProperty: Int {
        return 40 + 2
    }
}

SomeClass.computedTypeProperty

// methods

class Counter {
    var count = 0
    func increment() { count++ }
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    func reset() { count = 0 }
}

let counter = Counter()
counter.increment()
counter.incrementBy(5, numberOfTimes: 3)

// type methods

class SomeClass2 {
    class func someTypeMethod() {
        40 + 2
    }
}

SomeClass2.someTypeMethod()

// inheritance

class Vehicle {
  var numberOfWheels: Int
  var maxPassengers: Int

  func description() -> String {
    return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
  }

  init() {
    numberOfWheels = 0
    maxPassengers = 1
  }
}

class Bicycle: Vehicle {
  override init() {
    super.init()
    numberOfWheels = 2
  }
}

class Tandem: Bicycle {
  override init() {
    super.init()
    maxPassengers = 2
  }
}

let tandem = Tandem()
println("Tandem: \(tandem.description())")

class Car: Vehicle {
  var speed: Double = 0.0

  override init() {
    super.init()
      maxPassengers = 5
      numberOfWheels = 4
  }
  override func description() -> String {
    return super.description() + "; "
      + "traveling at \(speed) mph"
  }
}

let car = Car()
println("Car: \(car.description())")

class SpeedLimitedCar: Car {
  override var speed: Double {
    get {
      return super.speed
    }
    set {
      super.speed = min(newValue, 40.0)
    }
  }
}

let limitedCar = SpeedLimitedCar()
limitedCar.speed = 60.0
println("SpeedLimitedCar: \(limitedCar.description())")

class AutomaticCar: Car {
  var gear = 1

  override var speed: Double {
    didSet {
      gear = Int(speed / 10.0) + 1
    }
  }

  override func description() -> String {
    return super.description() + " in gear \(gear)"
  }
}

// initialization
//

struct Fahrenheit {
  var temperature = 32.0
}

// is the same as

struct Fahrenheit {
  var temperature: Double
  init() {
    temperature = 32.0
  }
}

struct Celsius {
  var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
    )  temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }

    init(fromKelvin kelvin: Double) {
      temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

// optional properties

class SurveyQuestion {
  var text: String
  var response: String?
  init(text: String) {
    self.text = text
  }
  func ask() {
    println(text)
  }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.response = "yes"

if cheeseQuestion.response != nil {
  println("woohoo!")
}

// default properties using closures

class SomeClass {
  let someProperty: Int = {
    return 5
  }()
}

struct Checkerboard {
  let boardColors: [Bool] = {
    var tempBoard = [Bool]()
    var isBlack = false
    for i in 1...10 {
      for j in 1...10 {
        tempBoard.append(isBlack)
        isBlack = !isBlack
      }
      isBlack = !isBlack
    }
    return tempBoard
  }()
  func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
    return boardColors[(row * 10) + column]
  }
}

let board = Checkerboard()
println(board.squareIsBlackAtRow(0, column: 1))

// == Generics ==

func repeat<ItemType>(item: ItemType, times: Int) -> [ItemType] {
    var result: [ItemType] = []
    for i in 0..<times {
        result.append(item)
    }
    return result
}

repeat("knock", 4)

// implementing optionals

enum OptionalValue<T> {
    case None
    case Some(T)
}

var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

// generic functions

func swapTwoValues<T>(inout a: T, inout b: T) {
  let temporaryA = a
  a = b
  b = temporaryA
}

// generic types

struct Stack<T> {
  var items = [T]()
  mutating func push(item: T) {
    items.append(item)
  }
  mutating func pop() -> T {
    return items.removeLast()
  }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.pop()

// type constraints

/*
func anyCommonElements <T, U where T: Sequence, U: Sequence, T.GeneratorType.Element: Equatable, T.GeneratorType.Element == U.GeneratorType.Element> (lhs: T, rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
}

anyCommonElements([1,2,3], [3])
*/

func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
  for (index, value) in enumerate(array) {
    if value == valueToFind {
      return index
    }
  }
  return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
let doubleIndex = findIndex(["a", "b", "c", "d"], "c")

// associated types

protocol Container {
  typealias ItemType
  mutating func append(item: ItemType)
  var count: Int { get }
  subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
  var items = [Int]()
  mutating func push(item: Int) {
    items.append(item)
  }
  mutating func pop() -> Int {
    return items.removeLast()
  }
  // conformance to protocol, typealias optional due to inference
  // typealias ItemType = Int

  mutating func append(item: Int) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> Int {
    return items[i]
  }
}

struct Stack<T>: Container {
  var items = [T]()
  mutating func push(item: T) {
    items.append(item)
  }
  mutating func pop() -> T {
    return items.removeLast()
  }
  // conformance to protocol, typealias optional due to inference
  // typealias ItemType = T

  mutating func append(item: T) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> T {
    return items[i]
  }
}

// extending existing types

extension Array: Container {}

// where clauses

func allItemsMatch <C1: Container, C2: Container
                    where C1.ItemType == C2.ItemType,
                    C1.ItemType: Equatable>
  (someContainer: C1, anotherContainer: C2) -> Bool {

  if someContainer.count != anotherContainer.count {
    return false
  }

  for i in 0..<someContainer.count {
    if someContainer[i] != anotherContainer[i] {
      return false
    }
  }

  return true
}

// allItemsMatch(["a", "b", "c"], [1,2,3]) -> Error!
// allItemsMatch(["a", "b", "c"], ["d", "e", "f"]) -> False

struct TimesTable {
  let multiplier: Int
  subscript(index: Int) -> Int {
    return multiplier * index
  }
}

let threeTimesTable = TimesTable(multiplier: 3)
println("six times three is \(threeTimesTable[6])")

struct Matrix {
  let rows: Int, columns: Int
  var grid: [Double]

  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    grid = Array(count: rows * columns, repeatedValue: 0.0)
  }

  func indexIsValidForRow(row: Int, _ column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }

  subscript(row: Int, column: Int) -> Double {
    get {
      assert(indexIsValidForRow(row, column), "Index out of range")
      return grid[(row * columns) + column]
    }
    set {
      assert(indexIsValidForRow(row, column), "Index out of range")
      grid[(row * columns) + column] = newValue
    }
  }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

// Assert raised
// let someValue = matrix[2, 2]

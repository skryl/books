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

// limiting types

// func anyCommonElements <T, U where T: Sequence, U: Sequence, T.GeneratorType.Element: Equatable, T.GeneratorType.Element == U.GeneratorType.Element> (lhs: T, rhs: U) -> Bool {
//     for lhsItem in lhs {
//         for rhsItem in rhs {
//             if lhsItem == rhsItem {
//                 return true
//             }
//         }
//     }
// }
//
// anyCommonElements([1,2,3], [3])

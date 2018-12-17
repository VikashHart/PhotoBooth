import Foundation

infix operator + : AdditionPrecedence

func +<K: Hashable,V>(lhs: [K : V], rhs: [K : V]) -> [K : V] {
    var lhsCopy = lhs
    lhsCopy.merge(rhs, uniquingKeysWith: { value1, _ in return value1})
    return lhsCopy
}

import Foundation

public struct Days<C>: Equatable where C : Equatable {
    public let year: Int
    public let month: Int
    public let items: [[Item<C>]]
}

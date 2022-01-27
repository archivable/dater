import Foundation

extension Days {
    public struct Item<C>: Equatable where C : Equatable {
        public let value: Int
        public let today: Bool
        public let content: C
    }
}

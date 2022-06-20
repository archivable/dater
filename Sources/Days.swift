import Foundation

public struct Days<C>: Equatable where C : Equatable {
    public let year: UInt16
    public let month: UInt8
    public let items: [[Item]]
}

import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    /// A type that describes why the system permanently invalidated a tip.
    public struct InvalidationReason: Hashable, Sendable {
        internal enum Value {
            case userClosedTip
            case userPerformedAction
            case maxDisplayCountExceeded
        }

        internal let value: Value
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips.InvalidationReason {
    /// The user explicitly closed the tip view while it was displaying.
    public static let userClosedTip = Self(value: .userClosedTip)
    /// The user performed the action that the tip describes.
    public static let userPerformedAction =  Self(value: .userPerformedAction)
    /// The tip exceeded its maximum display count.
    public static let maxDisplayCountExceeded = Self(value: .maxDisplayCountExceeded)
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension BackportTip {
    /// Permanently invalidates a tip and prevents it from displaying.
    ///
    /// - Parameters:
    ///   - reason: The reason for the tip's invalidation. The tip's `invalidationReason` returns this value after invalidation.
    public func invalidate(reason: Self.InvalidationReason) {
        fatalError()
    }
}

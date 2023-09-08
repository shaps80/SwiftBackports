import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    /// A type that describes why the system permanently invalidated a tip.
    public enum InvalidationReason: Hashable, Sendable {
        /// The user performed the action that the tip describes.
        case actionPerformed
        /// The tip exceeded its maximum display count.
        case displayCountExceeded
        /// The user explicitly closed the tip view while it was displaying.
        case tipClosed
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
internal extension Backport<Any>.Tips.InvalidationReason {
    var rawValue: Int16 {
        switch self {
        case .actionPerformed: return 1
        case .displayCountExceeded: return 4
        case .tipClosed: return 2
        }
    }

    init(rawValue: Int16) {
        switch rawValue {
        case 1: self = .actionPerformed
        case 4: self = .displayCountExceeded
        case 2: self = .tipClosed
        default: self = .tipClosed
        }
    }
}

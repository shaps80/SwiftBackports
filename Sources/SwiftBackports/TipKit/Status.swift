import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    public enum Status: Hashable, Sendable {
        /// The tip is not eligible for display.
        case pending

        /// The tip is eligible for display.
        case available

        /// The tip is no longer valid.
        case invalidated(InvalidationReason)

        public var rawValue: Int16 {
            switch self {
            case .pending: return 0
            case .available: return 1
            case .invalidated: return 2
            }
        }
    }
}

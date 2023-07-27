import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    /// A type that describes the current display eligibility status for a tip.
    public struct Status: Hashable, Sendable {
        /// A Boolean value that returns true when the status is available.
        public var shouldDisplay: Bool

        /// A Boolean value that returns true when the status is invalidated.
        public var isInvalidated: Bool
    }
}

import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    public struct TipKitError: LocalizedError, Hashable {
        internal enum Wrapped: LocalizedError {
            case invalidPredicateValueType
            case missingGroupContainerEntitlements
            case tipsDatastoreAlreadyConfigured
        }

        internal let wrapped: Wrapped

        public var errorDescription: String? {
            wrapped.localizedDescription
        }
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.TipKitError {
    public static let invalidPredicateValueType = Self(wrapped: .invalidPredicateValueType)
    public static let missingGroupContainerEntitlements = Self(wrapped: .missingGroupContainerEntitlements)
    public static let tipsDatastoreAlreadyConfigured = Self(wrapped: .tipsDatastoreAlreadyConfigured)
}

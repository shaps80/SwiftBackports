import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    public struct TipKitError: LocalizedError, Hashable {
        internal enum Value: LocalizedError {
            case invalidPredicateValueType
            case missingGroupContainerEntitlements
            case tipsDatastoreAlreadyConfigured
        }

        internal let value: Value

        public var errorDescription: String? {
            value.localizedDescription
        }
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.TipKitError {
    public static let invalidPredicateValueType = Self(value: .invalidPredicateValueType)
    public static let missingGroupContainerEntitlements = Self(value: .missingGroupContainerEntitlements)
    public static let tipsDatastoreAlreadyConfigured = Self(value: .tipsDatastoreAlreadyConfigured)
}

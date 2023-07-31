import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    /// A location for persisting your application's tips and associated data.
    ///
    /// You don't instantiate store locations directly. Instead use one of initialization methods to control how your tips persist and load.
    public struct DatastoreLocation: BackportTipsConfiguration {
        internal let url: URL
        internal let shouldReset: Bool

        /// DatastoreLocation for persisting tips at a custom URL.
        ///
        /// - Parameters:
        ///   - url: URL for persisting tips datastore.
        ///   - shouldReset: Set to true to erase TipKit's datastore. All existing tip statuses will be reset along with their rules, parameters, and events.
        public init(url: URL, shouldReset: Bool = false) {
            self.url = url
            self.shouldReset = shouldReset
        }

        /// DatastoreLocation using a predefined value.
        ///
        /// - Parameters:
        ///   - location: Predefined DatastoreLocation value.
        ///   - shouldReset: Set to true to erase TipKit's datastore. All existing tip statuses will be reset along with their rules, parameters, and events.
        public init(_ location: DatastoreLocation, shouldReset: Bool = false) {
            self.url = location.url
            self.shouldReset = shouldReset
        }

        /// DatastoreLocation for persisting tips in a group container.
        ///
        /// - Parameters:
        ///   - groupIdentifier: A string that names the group whose shared directory you want to obtain. This input should exactly match one of the strings in the app's App Groups Entitlement.
        ///   - directoryName: Optionally specify a directory within the group container.
        ///   - shouldReset: Set to true to erase TipKit's datastore. All existing tip statuses will be reset along with their rules, parameters, and events.
        public init(groupIdentifier: String, directoryName: String? = nil, shouldReset: Bool = false) throws {
            guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier) else {
                throw TipKitError.missingGroupContainerEntitlements
            }
            
            if let directoryName {
                self.url = url.appendingPathComponent(directoryName)
            } else {
                self.url = url
            }

            self.shouldReset = shouldReset
        }

        /// The default location for persisting tips, which is generally your application's support directory.
        public static var applicationDefault: DatastoreLocation {
            let url = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return .init(url: url.appendingPathComponent(".tipsbackport"))
        }
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
public typealias DatastoreLocation = Backport<Any>.DatastoreLocation

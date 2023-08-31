import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    public struct ConfigurationOption: Sendable {
        internal private(set) var datastoreLocation: DatastoreLocation = .applicationDefault
        internal private(set) var displayFrequency: DisplayFrequency = .immediate
        internal private(set) var apply: @Sendable (inout Self) -> Void = { _ in }
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips.ConfigurationOption {
    public static func displayFrequency(_ displayFrequency: DisplayFrequency) -> Self {
        .init { $0.displayFrequency = displayFrequency }
    }

    /// The frequency your tips display.
    ///
    /// Use this type to control how often your tips display.
    public struct DisplayFrequency: Equatable, Sendable {
        internal let duration: TimeInterval

        private init(duration: TimeInterval) {
            self.duration = duration
        }

        /// Display Frequency using a predefined value.
        public init(_ value: DisplayFrequency) {
            self.init(duration: value.duration)
        }

        /// An immediate display frequency.
        ///
        /// When you set this, the system shows tips with no limitations on frequency.
        public static var immediate: DisplayFrequency { .init(duration: 0) }

        /// A hourly display frequency.
        ///
        /// When you set this, the system shows no more than one tip per hour.
        public static var hourly: DisplayFrequency { .init(duration: 3600) }

        /// A daily display frequency.
        ///
        /// When you set this, the system shows no more than one tip per day.
        public static var daily: DisplayFrequency { .init(duration: 86_400) }

        /// A weekly display frequency.
        ///
        /// When you set this, the system shows no more than one tip per week.
        public static var weekly: DisplayFrequency { .init(duration: 604_800) }

        /// A monthly display frequency.
        ///
        /// When you set this, the system shows no more than one tip per month.
        public static var monthly: DisplayFrequency { .init(duration: 2_592_000) }
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips.ConfigurationOption {
    public static func datastoreLocation(_ storeLocation: DatastoreLocation) -> Self {
        .init { $0.datastoreLocation = storeLocation }
    }

    /// A location for persisting your application's tips and associated data.
    ///
    /// You don't instantiate store locations directly. Instead use one of initialization methods to control how your tips persist and load.
    public struct DatastoreLocation: Equatable, Sendable {
        internal let url: URL

        /// The default location for persisting tips, which is generally your application's support directory.
        public static var applicationDefault: DatastoreLocation {
            let url = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return .init(url: url.appendingPathComponent(".tipsbackport"))
        }

        /// DatastoreLocation for persisting tips in a group container.
        ///
        /// - Parameters:
        ///   - identifier: A string that names the group whose shared directory you want to obtain. This input should exactly match one of the strings in the app's App Groups Entitlement.
        public static func groupContainer(identifier: String) throws -> DatastoreLocation {
            guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: identifier) else {
                throw Backport<Any>.TipKitError.missingGroupContainerEntitlements
            }

            return .init(url: url)
        }

        /// DatastoreLocation for persisting tips at a custom URL.
        ///
        /// - Parameters:
        ///   - url: URL for persisting tips datastore.
        public static func url(_ url: URL) -> DatastoreLocation {
            .init(url: url)
        }
    }
}

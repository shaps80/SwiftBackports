import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    /// The frequency your tips display.
    ///
    /// Use this type to control how often your tips display.
    public struct DisplayFrequency: BackportTipsConfiguration {
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
public typealias DisplayFrequency = Backport<Any>.DisplayFrequency

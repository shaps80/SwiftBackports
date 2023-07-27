import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    /// The frequency your tips display.
    ///
    /// Use this type to control how often your tips display.
    public struct DisplayFrequency: BackportTipsConfiguration {

        /// Display Frequency using a predefined value.
        public init(_ value: DisplayFrequency) {
            fatalError()
        }

        /// An immediate display frequency.
        ///
        /// When you set this, the system shows tips with no limitations on frequency.
        public static var immediate: DisplayFrequency { fatalError() }

        /// A hourly display frequency.
        ///
        /// When you set this, the system shows no more than one tip per hour.
        public static var hourly: DisplayFrequency { fatalError() }

        /// A daily display frequency.
        ///
        /// When you set this, the system shows no more than one tip per day.
        public static var daily: DisplayFrequency { fatalError() }

        /// A weekly display frequency.
        ///
        /// When you set this, the system shows no more than one tip per week.
        public static var weekly: DisplayFrequency { fatalError() }

        /// A monthly display frequency.
        ///
        /// When you set this, the system shows no more than one tip per month.
        public static var monthly: DisplayFrequency { fatalError() }
    }
}

import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
public protocol BackportTipOption: Sendable { }

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    /// Controls whether a tip obeys the preconfigured frequency control interval.
    ///
    /// The default value is `false`.
    public struct IgnoresDisplayFrequency: BackportTipOption {
        let value: Bool
        public init(_ ignoresDisplayFrequency: Bool) {
            value = ignoresDisplayFrequency
        }
    }

    /// Specifies the maximum number of times a tip displays before the system automatically invalidates it.
    ///
    /// The default value is `nil`.
    public struct MaxDisplayCount: BackportTipOption {
        let value: Int
        public init(_ maxDisplayCount: Int) {
            value = maxDisplayCount
        }
    }

    public struct CloudSyncEnabled: BackportTipOption {
        let value: Bool
        public init(_ cloudSyncEnabled: Bool) {
            value = cloudSyncEnabled
        }
    }
}

//extension BackportTipOption where Self == Backport<Any>.Tips.MaxDisplayCount {
//    /// Specifies the maximum number of times a tip displays before the system automatically invalidates it.
//    ///
//    /// The default value is `nil`.
//    static func maxDisplayCount(_ displayCount: Int) -> Self { .init(displayCount) }
//}

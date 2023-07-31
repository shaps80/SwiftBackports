import SwiftUI

/// A type that marks an object as a tip configuration.
@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
public protocol BackportTipsConfiguration: Sendable { }

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    /// The default configuration for tips.
    public static var defaultConfiguration: some BackportTipsConfiguration {
        ConfigurationValues.shared
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    @resultBuilder public struct BackportTipsConfigurationBuilder {
        public static func buildExpression(_ child: some BackportTipsConfiguration) -> some BackportTipsConfiguration {
            ConfigurationValues.shared.update(with: child)
            return ConfigurationValues.shared
        }

        public static func buildExpression(_ child: (some BackportTipsConfiguration)?) -> some BackportTipsConfiguration {
            if let child {
                ConfigurationValues.shared.update(with: child)
            }
            return ConfigurationValues.shared
        }

        public static func buildExpression(_ child: [some BackportTipsConfiguration]) -> some BackportTipsConfiguration {
            for c in child {
                ConfigurationValues.shared.update(with: c)
            }
            return ConfigurationValues.shared
        }

        public static func buildExpression(_ child: [(BackportTipsConfiguration)?]) -> some BackportTipsConfiguration {
            for c in child.compactMap({ $0 }) {
                ConfigurationValues.shared.update(with: c)
            }
            return ConfigurationValues.shared
        }

        public static func buildEither(first: some BackportTipsConfiguration) -> some BackportTipsConfiguration {
            ConfigurationValues.shared.update(with: first)
            return ConfigurationValues.shared
        }

        public static func buildEither(second: some BackportTipsConfiguration) -> some BackportTipsConfiguration {
            ConfigurationValues.shared.update(with: second)
            return ConfigurationValues.shared
        }

        public static func buildOptional(_ component: (BackportTipsConfiguration)?) -> some BackportTipsConfiguration {
            if let component {
                ConfigurationValues.shared.update(with: component)
            }
            return ConfigurationValues.shared
        }

        public static func buildOptional(_ component: [(BackportTipsConfiguration)?]) -> some BackportTipsConfiguration {
            for c in component.compactMap({ $0 }) {
                ConfigurationValues.shared.update(with: c)
            }
            return ConfigurationValues.shared
        }

        public static func buildBlock() -> some BackportTipsConfiguration {
            ConfigurationValues.shared
        }

        public static func buildPartialBlock(first: some BackportTipsConfiguration) -> some BackportTipsConfiguration {
            ConfigurationValues.shared.update(with: first)
            return ConfigurationValues.shared
        }

        public static func buildPartialBlock(accumulated: some BackportTipsConfiguration, next: some BackportTipsConfiguration) -> some BackportTipsConfiguration {
            ConfigurationValues.shared.update(with: accumulated)
            ConfigurationValues.shared.update(with: next)
            return ConfigurationValues.shared
        }
    }
}

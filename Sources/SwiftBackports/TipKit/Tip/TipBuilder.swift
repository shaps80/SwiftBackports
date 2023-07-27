import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    /// The result builder for generating a tip's actions.
    @resultBuilder public struct ActionBuilder {

        /// Builds a tip's actions set from a single action value.
        @inlinable public static func buildExpression(_ element: Action) -> [Action] {
            [element]
        }

        /// Builds a tip's actions set from an array of actions.
        @inlinable public static func buildExpression(_ component: [Action]) -> [Action] {
            component
        }

        /// Builds a tip's actions set from an array of actions.
        @inlinable public static func buildPartialBlock(first: [Action]) -> [Action] {
            first
        }

        /// Builds a tip's actions set by appending an array of actions.
        @inlinable public static func buildPartialBlock(accumulated: [Action], next: [Action]) -> [Action] {
            accumulated + next
        }

        /// Builds a tip's actions set from a nested array of actions.
        @inlinable public static func buildArray(_ components: [[Action]]) -> [Action] {
            components.flatMap { $0 }
        }

        /// Builds a tip's actions set from an if-else statement that produces an array of actions from the if-then branch.
        @inlinable public static func buildEither(first component: [Action]) -> [Action] {
            component
        }

        /// Builds a tip's actions set from an if-else statement that produces an array of actions from the else branch.
        @inlinable public static func buildEither(second component: [Action]) -> [Action] {
            component
        }

        @inlinable public static func buildLimitedAvailability(_ component: [Action]) -> [Action] {
            component
        }

        /// Builds a tip's actions set from an if statement.
        @inlinable public static func buildOptional(_ component: [Action]?) -> [Action] {
            component ?? []
        }

        /// Builds a final set of actions that the tip's view uses.
        @inlinable public static func buildFinalResult(_ component: [Action]) -> [Action] {
            #warning("Calculate indexes and update all null-id properties accordingly")
            return component
        }
    }
}

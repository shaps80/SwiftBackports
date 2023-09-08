import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    /// A type that describes a control associated with a tip.
    ///
    /// Use actions to provide additional help and guidance for people looking to get started with your tip.
    /// Actions appear at the bottom of your ``TipView`` in the form of buttons.
    ///
    /// You create an action by providing an `id` and a `title`.
    /// The `id` is a string that uniquely identifies the action.
    /// The `title` is text that displays as the label on the button.
    ///
    /// You can pass a function for the system to call when the action triggers by setting the `perform`
    /// attribute in the ``Action/init(id:title:disabled:perform:)`` initializer.
    /// Or you can set the action parameter in the ``TipView/init(_:arrowEdge:action:)`` initializer of your ``TipView``.
    public struct Action: Identifiable, Sendable {
        /// The identifier for a tip's action.
        ///
        /// If you don't specify a value in the initializer, the system assigns one based on the value of the `index`.
        public internal(set) var id: String

        public internal(set) var index: Int? = nil

        public let label: Text
        public let disabled: Bool
        public let handler: (@Sendable () -> Void)?

        /// Creates a tip action that displays a custom label.
        ///
        /// - Parameters:
        ///   - id: An optional identifier associated with the action. If you don't specify a value, the system assigns the action's `index` to this value.
        ///   - disabled: A condition that indicates whether users can interact with the button. Defaults to `false`.
        ///   - perform: The function the system calls when the action triggers.
        ///   - label: A view that describes the purpose of the tip action.
        public init(id: String? = nil, disabled: Bool = false, perform handler: (@Sendable () -> Void)? = nil, _ label: @escaping @Sendable () -> Text) {
            self.id = id ?? ""
            self.disabled = disabled
            self.handler = handler
            self.label = label()
        }

        /// Creates a tip action that generates its label from a string.
        ///
        /// - Parameters:
        ///   - id: An optional identifier associated with the action. If you don't specify a value, the system assigns the action's `index` to this value.
        ///   - title: A string that describes the purpose of the tip action.
        ///   - disabled: A condition that indicates whether users can interact with the button. Defaults to `false`.
        ///   - perform: The function the system calls when the action triggers.
        public init(id: String? = nil, title: some StringProtocol, disabled: Bool = false, perform handler: (@Sendable () -> Void)? = nil) {
            self.id = id ?? ""
            self.disabled = disabled
            self.handler = handler
            self.label = Text(title)
        }
    }
}

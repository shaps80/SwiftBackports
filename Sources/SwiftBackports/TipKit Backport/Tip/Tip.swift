import SwiftUI

/// A type that sets a tip's content, as well as the conditions for when it displays.
///
/// Use this protocol for setting a tip's content, as well as defining the conditions for when it appears in a view.
/// You create custom tips by declaring types that conform to the `Tip` protocol.
/// Set your tip's content by giving it a ``title``,  ``message``,  ``asset``,
/// and a list of ``actions``. For example, to create a tip with a `title`, `message`, and `asset`:
///
/// ```swift
/// struct FavoriteTip: Tip {
///     var title: Text {
///         Text("Save as a Favorite")
///     }
///
///     var message: Text? {
///         Text("Your favorite backyards always appear at the top of the list.")
///     }
///
///     var asset: Image? {
///         Image(systemName: "star")
///     }
/// }
/// ```
///
/// For a tip to be valid, you need to set its `title`.
/// To control when a tip displays, pass instances of ``Rule`` and ``Option`` into the
/// ``rules`` and ``options`` properties of the tip.
///
/// After you define your tip's content, display it in a ``TipView`` or a ``SwiftUI/View/popoverTip(_:arrowEdge:action:)``.
@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
public protocol BackportTip: Identifiable, Sendable {
    /// The tip's unique identifier.
    ///
    /// If you don't provide a value, the system assigns the name of the type that conforms to the `Tip` protocol during initialization.
    var id: String { get }
    /// A title that names the tip.
    ///
    /// Use this property to convey the benefit of your tip. All tips require a title.
    var title: Text { get }
    /// A short description of how to use the tip's feature.
    ///
    /// This property is `Optional` and defaults to a value of `nil`.
    var message: Text? { get }
    /// The image associated with the tip.
    ///
    /// Use this property to display an icon to the left of the `title` and `message` of your tip.
    /// This property is `Optional` and defaults to a value of `nil`.
    var asset: Image? { get }

//    /// Buttons that help people get started or learn more about your feature.
//    ///
//    /// Use actions to provide primary and secondary buttons to help people get started or learn more
//    /// about your feature. If you don't supply a value, this property returns an empty array of type `Action`.
    @Backport<Any>.Tips.ActionBuilder var actions: [Self.Action] { get }
//
//    /// The rules that determine when a tip is eligible for display.
//    ///
//    /// Use this property to define the rules for when your tips display.
//    /// If you don't supply a value, this property returns an empty array of type `Rule`.
//    @Tips.RuleBuilder var rules: [Self.Rule] { get }

    /// Customizations for a tip.
    @Backport<Any>.Tips.OptionsBuilder var options: [Option] { get }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension BackportTip {
    /// The current status of a tip based on frequency control and display rules.
    public var status: Self.Status {
        fatalError()
    }

    /// A Boolean value that determines whether to display a tip.
    ///
    /// This value returns `true` when a tip's status is `.available`,  and `false` otherwise.
    public var shouldDisplay: Bool {
        fatalError()
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips.Status {
    /// The tip is not eligible for display.
    ///
    /// Use this value when the tip fails to satisfy one or more rules or the current frequency control blocks it.
    public static var pending: Self {
        fatalError()
    }

    /// The tip is eligible for display.
    ///
    /// Use this value when the tip satisfies all its display rules and the frequency control doesn't block.
    public static var available: Self {
        fatalError()
    }

    /// The tip is no longer valid.
    ///
    /// Use this value when the user closes the tip view, the tip exceeds its max display count, or you invalidate the tip programmatically.
    public static var invalidated: Self {
        fatalError()
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension BackportTip {
    public var id: String { String(describing: type(of: self)) }
    public var message: Text? { nil }
    public var asset: Image? { nil }
//    public var rules: [Self.Rule] { [] }
    public var actions: [Self.Action] { [] }
    public var options: [Self.Option] { [] }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension BackportTip {
    /// A type that describes the current display eligibility status for a tip.
    public typealias Status = Backport<Any>.Tips.Status

    /// A type that describes why the system permanently invalidated a tip.
    public typealias InvalidationReason = Backport<Any>.Tips.InvalidationReason

    /// A type that describes a control associated with a tip.
    public typealias Action = Backport<Any>.Tips.Action

//    /// A type that defines a display rule to satisfy before displaying a tip.
//    public typealias Rule = Backport<Any>.Tips.Rule
//
//    /// A repeatable user-defined action.
//    public typealias Event = Backport<Any>.Tips.Event

    /// A type that represents the various customizations that you can make to a tip's behavior.
    public typealias Option = BackportTipOption

    /// Controls whether a tip obeys the preconfigured frequency control interval.
    public typealias IgnoresDisplayFrequency = Backport<Any>.Tips.IgnoresDisplayFrequency

    /// Specifies the maximum number of times a tip displays before the system automatically invalidates it.
    public typealias MaxDisplayCount = Backport<Any>.Tips.MaxDisplayCount
}

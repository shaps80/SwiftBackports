import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    /// A type-erased tip value.
    public struct AnyTip: BackportTip {
        public var id: String
        public var title: Text
        public var message: Text?
        public var image: Image?
        public var actions: [Action]
//        public var rules: [AnyTip.Rule]
        public var options: [BackportTipOption]

        public init(_ tip: some BackportTip) {
            id = tip.id
            title = tip.title
            message = tip.message
            image = tip.image
            actions = tip.actions
            options = tip.options
        }

        public init(erasing tip: some BackportTip) {
            self.init(tip)
        }
    }
}

import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    /// A type-erased tip value.
    public struct AnyTip: BackportTip {
        public var id: String
        public var title: Text
        public var message: Text?
        public var asset: Image?
        public var actions: [Action]

        public init(_ tip: some BackportTip) {
            id = tip.id
            title = tip.title
            message = tip.message
            asset = tip.asset
            actions = tip.actions
        }

        public init(erasing tip: some BackportTip) {
            self.init(tip)
        }
    }
}

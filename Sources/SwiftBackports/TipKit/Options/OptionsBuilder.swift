import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    @resultBuilder public struct OptionsBuilder {
        public static func buildExpression(_ child: some BackportTipOption) -> some BackportTipOption {
            TipOptions(child)
        }
        
        public static func buildExpression(_ child: (BackportTipOption)?) -> some BackportTipOption {
            TipOptions(child)
        }
        
        public static func buildExpression(_ child: [some BackportTipOption]) -> some BackportTipOption {
            TipOptions(contentsOf: child)
        }
        
        public static func buildExpression(_ child: [(BackportTipOption)?]) -> some BackportTipOption {
            TipOptions(contentsOf: child)
        }
        
        public static func buildEither(first: some BackportTipOption) -> some BackportTipOption {
            TipOptions(first)
        }

        public static func buildEither(second: some BackportTipOption) -> some BackportTipOption {
            TipOptions(second)
        }

        public static func buildOptional(_ component: (BackportTipOption)?) -> some BackportTipOption {
            TipOptions(component)
        }

        public static func buildOptional(_ component: [(BackportTipOption)?]) -> some BackportTipOption {
            TipOptions(contentsOf: component)
        }

        public static func buildBlock() -> some BackportTipOption {
            TipOptions(nil)
        }

        public static func buildPartialBlock(first: some BackportTipOption) -> some BackportTipOption {
            TipOptions(first)
        }

        public static func buildPartialBlock(accumulated: some BackportTipOption, next: some BackportTipOption) -> some BackportTipOption {
            TipOptions(contentsOf: [accumulated, next])
        }

        public static func buildFinalResult(_ component: some BackportTipOption) -> [BackportTipOption] {
            guard var component = component as? TipOptions else { return [] }
            component.elements.append(CloudSyncEnabled(true))
            return component.elements
        }
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
internal struct TipOptions: BackportTipOption {
    var elements: [BackportTipOption]

    init(contentsOf elements: [BackportTipOption]) {
        self.elements = elements
    }

    init(contentsOf elements: [BackportTipOption?]) {
        self.elements = elements.compactMap { $0 }
    }

    init(_ element: BackportTipOption?) {
        if let options = element as? TipOptions {
            self.elements = options.elements
        } else {
            self.elements = [element].compactMap { $0 }
        }
    }
}

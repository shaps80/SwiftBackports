import SwiftUI

@propertyWrapper
public struct Tip: DynamicProperty {
    @ObservedObject private var observer: TipObserver

    public var wrappedValue: Backport<Any>.AnyTip {
        observer.tip
    }

    public init(tip: Backport<Any>.AnyTip) {
        observer = .init(tip: tip)
    }
}

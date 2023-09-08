import SwiftUI
@_implementationOnly import Combine

final class TipObserver: ObservableObject {
    @Published var tip: Backport<Any>.AnyTip
    private var cancellable: Cancellable?

    init(tip: Backport<Any>.AnyTip) {
        self.tip = tip
        cancellable = TipsResultsController.shared.subscribe(to: tip) { [weak self] in
            DispatchQueue.main.async {
                self?.tip = tip
            }
        }
    }

    deinit {
        cancellable?.cancel()
        cancellable = nil
    }
}

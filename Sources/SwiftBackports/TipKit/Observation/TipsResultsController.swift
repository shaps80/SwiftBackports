import SwiftUI
@_implementationOnly import CoreData
@_implementationOnly import Combine

final class TipsResultsController: NSObject, NSFetchedResultsControllerDelegate {
    typealias Tips = Backport<Any>.Tips
    typealias ChangeHandler = () -> Void

    let controller: NSFetchedResultsController<CoreTipRecord>
    static let shared: TipsResultsController = .init()

    private var observers: [AnyHashable: ChangeHandler] = [:]

    private override init() {
        let request = CoreTipRecord.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "statusValue", ascending: true)]
        controller = .init(fetchRequest: request, managedObjectContext: Tips.store.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        controller.delegate = self
        try? controller.performFetch()
    }

    func subscribe(to tip: Backport<Any>.AnyTip, onChange: @escaping ChangeHandler) -> Cancellable {
        observers[tip.id] = onChange

        let subscription = Subscription { [weak self] in
            self?.observers.removeValue(forKey: tip.id)
        }

        onChange()
        return subscription
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let tip = anObject as? CoreTipRecord, let id = tip.id else { return }
        observers[id]?()
    }
}

private final class Subscription: Cancellable {
    static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    /// A closure that will be called when the subscription is cancelled.
    typealias CancelClosure = () -> Void

    private var cancelClosure: CancelClosure?

    /**
     Create a new subscription that will call the provided closure when cancelled.
     - parameter cancel: The closure to call when the subscription is cancelled.
     */
    required init(cancel: @escaping CancelClosure) {
        cancelClosure = cancel
    }

    deinit {
        cancel()
    }

    /**
     Cancel the subscription, preventing further updates being sent to the update listener, freeing any
     resources held on to by the subscription.
     */
    func cancel() {
        guard let cancelClosure = cancelClosure else { return }
        cancelClosure()
        self.cancelClosure = nil
    }

    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(self).hash(into: &hasher)
    }
}

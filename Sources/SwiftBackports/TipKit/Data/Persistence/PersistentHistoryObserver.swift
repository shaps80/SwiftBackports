@_implementationOnly import CoreData

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
final class PersistentHistoryObserver {
    private let target: AppTarget
    private let userDefaults: UserDefaults
    private let persistentContainer: PersistentContainer

    /// An operation queue for processing history transactions.
    private lazy var historyQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    public init(target: AppTarget, persistentContainer: PersistentContainer, userDefaults: UserDefaults) {
        self.target = target
        self.userDefaults = userDefaults
        self.persistentContainer = persistentContainer
    }

    public func startObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(processStoreRemoteChanges), name: .NSPersistentStoreRemoteChange, object: persistentContainer.persistentStoreCoordinator)
    }

    /// Process persistent history to merge changes from other coordinators.
    @objc private func processStoreRemoteChanges(_ notification: Notification) {
        historyQueue.addOperation { [weak self] in
            self?.processPersistentHistory()
        }
    }

    @objc private func processPersistentHistory() {
        let context = persistentContainer.newBackgroundContext()
        context.performAndWait {
            do {
                let merger = PersistentHistoryMerger(backgroundContext: context, viewContext: persistentContainer.viewContext, currentTarget: target, userDefaults: userDefaults)
                try merger.merge()

                let cleaner = PersistentHistoryCleaner(context: context, targets: AppTarget.allCases, userDefaults: userDefaults)
                try cleaner.clean()
            } catch { }
        }
    }
}

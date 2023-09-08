@_implementationOnly import CoreData

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
internal enum AppTarget: String, CaseIterable {
    case ios = "iOS"
    case macos = "macOS"
    case tvos = "tvOS"
    case wtchOS = "watchOS"
    case iosWidget = "iOS.Widget"
    case macosWidget = "macOS.Widget"

    public static var current: AppTarget {
        allCases.first { target in
            Bundle.main.bundleIdentifier?.hasSuffix(target.rawValue.lowercased()) == true
        } ?? .ios
    }
}

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
internal final class PersistentContainer: NSPersistentCloudKitContainer {
    func author(for target: AppTarget) -> String {
        [Bundle.main.bundleIdentifier, target.rawValue]
            .compactMap { $0 }
            .joined(separator: ".")
    }

    public static let shared: PersistentContainer = .init(name: "tips-store", managedObjectModel: .model)

    private lazy var observer: PersistentHistoryObserver = {
        PersistentHistoryObserver(
            target: .current,
            persistentContainer: self,
            userDefaults: .standard
        )
    }()

    func prepare(at url: URL) async throws {
        let description = persistentStoreDescriptions.first
        description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        description?.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
        description?.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
        description?.url = url.appendingPathComponent("\(name).db")

        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            loadPersistentStores { [unowned self] description, error in
                switch error {
                case let .some(error as NSError):
                    continuation.resume(throwing: error)
                case .none:
                    DispatchQueue.main.async {
                        self.completePreparing()
                        continuation.resume()
                    }
                }
            }
        }
    }

    internal func destroyPersistentStore(at url: URL) {
        let url = url.appendingPathComponent("\(name).sqlite")

        do {
            try persistentStoreCoordinator.destroyPersistentStore(
                at: url,
                ofType: NSSQLiteStoreType,
                options: nil
            )

            let coordinator = NSFileCoordinator(filePresenter: nil)
            coordinator.coordinate(writingItemAt: url, options: .forDeleting, error: nil) { _ in
                do {
                    try FileManager.default.removeItem(at: url)
                } catch {
                    print("Failed to delete old store")
                    print("\(error.localizedDescription)")
                }
            }
        } catch {
            print("Failed to destroy old store")
            print("\(error.localizedDescription)")
        }
    }

    @MainActor
    private func completePreparing() {
        viewContext.name = "view_context"
        viewContext.transactionAuthor = AppTarget.current.rawValue
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.undoManager = nil

        try? viewContext.setQueryGenerationFrom(.current)
        observer.startObserving()
    }

    public private(set) lazy var insertContext = {
        let context = newBackgroundContext()
        context.name = "insert_context"
        return context
    }()

    public override func newBackgroundContext() -> NSManagedObjectContext {
        let context = super.newBackgroundContext()
        context.transactionAuthor = AppTarget.current.rawValue
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        context.undoManager = nil
        return context
    }

    @available(swift, obsoleted: 1.0, renamed: "performTask(_:)")
    public override func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        fatalError("Do not use this directly, instead call performTask(_:)")
    }

    public func performTask(_ block: @escaping (NSManagedObjectContext) throws -> Void) {
        super.performBackgroundTask { context in
            context.transactionAuthor = AppTarget.current.rawValue
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            context.automaticallyMergesChangesFromParent = true
            context.undoManager = nil

            do {
                try block(context)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }

}

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
internal extension NSManagedObjectContext {
    func saveImmediately() {
        guard hasChanges else { return }

        performAndWait {
            do {
                try save()
            } catch {
                let error = error as NSError
                print("Failed to save with error: \(error) | \(error.userInfo)")
            }
        }
    }

}

@_implementationOnly import CoreData

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
struct PersistentHistoryCleaner {
    let context: NSManagedObjectContext
    let targets: [AppTarget]
    let userDefaults: UserDefaults

    /// Cleans up the persistent history by deleting the transactions that have been merged into each target.
    func clean() throws {
        guard let timestamp = userDefaults.lastCommonTransactionTimestamp(in: targets) else { return }

        let deleteHistoryRequest = NSPersistentHistoryChangeRequest.deleteHistory(before: timestamp)
        try context.execute(deleteHistoryRequest)

        targets.forEach { target in
            /// Reset the dates as we would otherwise end up in an infinite loop.
            userDefaults.updateLastHistoryTransactionTimestamp(for: target, to: nil)
        }
    }
}

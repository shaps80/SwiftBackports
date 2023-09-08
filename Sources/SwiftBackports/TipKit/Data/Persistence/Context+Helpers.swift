@_implementationOnly import CoreData

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
extension NSManagedObjectContext {
    func deleteAll<T: NSManagedObject>(ofType type: T.Type) throws {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()

        guard request.entity != nil, try count(for: request) > 0 else { return }

        let batchRequest = NSBatchDeleteRequest(fetchRequest: request)
        _ = try execute(batchRequest)
        print("Reset \(T.self) data")
    }
}

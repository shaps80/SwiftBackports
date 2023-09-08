@_implementationOnly import CoreData

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
extension NSManagedObjectContext {
    static var viewContext: NSManagedObjectContext {
        PersistentContainer.shared.viewContext
    }
}

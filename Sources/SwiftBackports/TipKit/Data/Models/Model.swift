@_implementationOnly import CoreData

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
internal extension NSManagedObjectModel {
    static var model: NSManagedObjectModel {
        let model = NSManagedObjectModel()
        model.entities = [
            CoreTipRecord.entity,
        ]
        return model
    }
}

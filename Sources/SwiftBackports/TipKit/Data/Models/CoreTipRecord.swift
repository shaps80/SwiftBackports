@_implementationOnly import CoreData

struct TipInfo: Codable {
    var bundleId: String? = Bundle.main.bundleIdentifier
    var displayDates: [Date] = []
    var displayCount: Int = 0
    var isArchived: Bool = false

    // options
    var cloudSyncEnabled: Bool = true
    var ignoresDisplayFrequency: Bool = false
    var maxDisplayCount: Int = .max
}

@objc(CoreTipRecord)
internal final class CoreTipRecord: NSManagedObject, Identifiable {
    @NSManaged public var id: String?
    /*
     let formatter = DateFormatter()
     formatter.timeZone = TimeZone(abbreviation: "UTC")
     formatter.dateFormat = "yyyy-MM-dd HH:mm:sss"
     */
    @NSManaged public var lastDisplayed: Date?
    @NSManaged public var invalidationReason: Int16
    @NSManaged public var statusValue: Int16
    @NSManaged public var tipInfo: Data?

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreTipRecord> {
        return NSFetchRequest<CoreTipRecord>(entityName: "CoreTipRecord")
    }
}

extension CoreTipRecord {
    var info: TipInfo {
        get {
            let iso = DateFormatter()
            iso.timeZone = TimeZone(abbreviation: "UTC")
            iso.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(iso)
            
            guard
                let tipInfo,
                let decoded = try? decoder.decode(TipInfo.self, from: tipInfo)
            else { return .init() }
            return decoded
        } set {
            do {
                let iso = DateFormatter()
                iso.timeZone = TimeZone(abbreviation: "UTC")
                iso.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .formatted(iso)
                encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
                tipInfo = try encoder.encode(newValue)
            } catch {
                print(error)
            }
        }
    }
}

extension CoreTipRecord {
//    @NSManaged public var attachments: NSSet?

//    @objc(addAttachmentsObject:)
//    @NSManaged public func addToAttachments(_ value: Attachment)
//
//    @objc(removeAttachmentsObject:)
//    @NSManaged public func removeFromAttachments(_ value: Attachment)
//
//    @objc(addAttachments:)
//    @NSManaged public func addToAttachments(_ values: NSSet)
//
//    @objc(removeAttachments:)
//    @NSManaged public func removeFromAttachments(_ values: NSSet)
}

extension CoreTipRecord {
    static let entity: NSEntityDescription = {
        let entity = NSEntityDescription()
        entity.name = "CoreTipRecord"
        entity.managedObjectClassName = "CoreTipRecord"

        let id = NSAttributeDescription()
        id.attributeType = .stringAttributeType
        id.name = "id"

        let lastDisplayed = NSAttributeDescription()
        lastDisplayed.attributeType = .dateAttributeType
        lastDisplayed.name = "lastDisplayed"

        let reason = NSAttributeDescription()
        reason.attributeType = .integer16AttributeType
        reason.name = "invalidationReason"

        let status = NSAttributeDescription()
        status.attributeType = .integer16AttributeType
        status.name = "statusValue"

        let info = NSAttributeDescription()
        info.attributeType = .binaryDataAttributeType
        info.name = "tipInfo"

        entity.properties = [
            id, lastDisplayed, reason, status, info
        ]

        return entity
    }()
}

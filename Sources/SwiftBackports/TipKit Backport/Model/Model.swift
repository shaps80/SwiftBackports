import CoreData

/*
 {
    bundleID = "com.benkau.TipKitDemo.TipKitDemo";
    cloudSyncEnabled = 1;
    displayCount = 2;
    displayDates =     (
        "2023-07-27 20:28:18 +0000",
        "2023-07-27 20:28:24 +0000"
    );
    ignoresDisplayFrequency = 0;
    isArchived = 0;
    maxDisplayCount = 9223372036854775807;
}
 */

struct TipInfo: Codable {
    var bundleId: String? = Bundle.main.bundleIdentifier

    /*
     let iso = DateFormatter()
     iso.timeZone = TimeZone(abbreviation: "UTC")
     iso.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
     */
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
            let decoder = JSONDecoder()
            guard
                let tipInfo,
                let decoded = try? decoder.decode(TipInfo.self, from: tipInfo)
            else { return .init() }
            return decoded
        } set {
            do {
                let encoder = JSONEncoder()
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

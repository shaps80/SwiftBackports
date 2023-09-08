import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension BackportTip {
    /// Permanently invalidates a tip and prevents it from displaying.
    ///
    /// - Parameters:
    ///   - reason: The reason for the tip's invalidation. The tip's `invalidationReason` returns this value after invalidation.
    public func invalidate(reason: InvalidationReason) {
        let context = Tips.store.viewContext
        let tip = coreTip
        tip.statusValue = 2
        tip.invalidationReason = reason.rawValue
        context.saveImmediately()
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
internal extension BackportTip {
    typealias Tips = Backport<Any>.Tips

    // Fetches an existing (or creates a new) tip, updates its options and returns it
    var coreTip: CoreTipRecord {
        let context = Tips.store.viewContext
        let request = CoreTipRecord.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: ["id", id])
        request.fetchLimit = 1

        let model = (try? context.fetch(request).first) ?? .init(context: context)
        model.id = id

        if context.insertedObjects.contains(model) {
            model.invalidationReason = 1
            model.statusValue = 1
        }

        // update options
        for option in options {
            if let option = option as? Tips.IgnoresDisplayFrequency {
                model.info.ignoresDisplayFrequency = option.value
            } else if let option = option as? Tips.MaxDisplayCount {
                model.info.maxDisplayCount = option.value
            }
        }

        return model
    }
}

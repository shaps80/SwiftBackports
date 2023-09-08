import Foundation

@available(iOS, introduced: 13)
@available(tvOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(watchOS, introduced: 6)
internal extension UserDefaults {
    func lastHistoryTransactionTimestamp(for target: AppTarget) -> Date? {
        let key = "tipkit.history.timestamp.\(target.rawValue)"
        return object(forKey: key) as? Date
    }

    func updateLastHistoryTransactionTimestamp(for target: AppTarget, to newValue: Date?) {
        let key = "tipkit.history.timestamp.\(target.rawValue)"
        set(newValue, forKey: key)
    }

    func lastCommonTransactionTimestamp(in targets: [AppTarget]) -> Date? {
        let timestamp = targets
            .map { lastHistoryTransactionTimestamp(for: $0) ?? .distantPast }
            .min() ?? .distantPast
        return timestamp > .distantPast ? timestamp : nil
    }
}

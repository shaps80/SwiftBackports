import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    @frozen public enum Tips { }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    private static var configured: Bool = false
    private static var reset: Bool = false

    /// Called at app startup to load and configure the persistent state of all tips in your app:
    ///
    /// ```swift
    /// @main
    /// struct AppView: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .task {
    ///                     try? Tips.configure([
    ///                         .datastoreLocation(.applicationDefault),
    ///                         .displayFrequency(.immediate)
    ///                     ])
    ///                 }
    ///         }
    ///     }
    /// }
    /// ```
    /// Configures an app's tips.
    ///
    /// - Parameters:
    ///   - configuration: An array of options for customizing your tip's datastore location and default frequency control interval.
    public static func configure(_ configuration: [ConfigurationOption] = []) throws {
        guard !configured else { throw Backport<Any>.TipKitError.tipsDatastoreAlreadyConfigured }

        var options = ConfigurationOption()
        configuration.forEach { $0.apply(&options) }

        if reset {
            if FileManager.default.fileExists(atPath: options.datastoreLocation.url.path) {
                try FileManager.default.removeItem(at: options.datastoreLocation.url)
            }
            reset = false
        }

        let manager = FileManager.default
        if !manager.fileExists(atPath: options.datastoreLocation.url.path) {
            try manager.createDirectory(at: options.datastoreLocation.url, withIntermediateDirectories: true)
        }

#warning("Prepare models")
        /*
         This would include the following:

         - prepare the model (tips-store)
         - load the persistent store
         */

        configured = true
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    /// Resets the tips' datastore to the initial state for re-testing tip display rules and eligibility.
    /// Must be called before ``Tips/configure(options:)``.
    ///
    /// ```swift
    /// import SwiftUI
    /// import TipKit
    ///
    /// @main
    /// struct LandmarkTips: App {
    ///     @AppStorage("shouldResetTips")
    ///     var shouldResetTips: Bool = true
    ///
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .task {
    ///                     if shouldResetTips {
    ///                         try? Tips.resetDatastore()
    ///                     }
    ///
    ///                     try? Tips.configure([
    ///                         .displayFrequency(.immediate),
    ///                         .datastoreLocation(.applicationDefault)
    ///                     ])
    ///                 }
    ///         }
    ///     }
    /// }
    /// ```
    public static func resetDatastore() throws {
        guard !configured else { throw Backport<Any>.TipKitError.tipsDatastoreAlreadyConfigured }
        reset = true
    }

    /// Show all tips regardless of their display rule eligibility or display frequency status for UI testing of tips.
    public static func showAllTipsForTesting() {
        fatalError()
    }

    /// Show specified tips regardless of their display rule eligibility or display frequency status for UI testing of certain tips.
    ///
    /// - Parameters:
    ///   - tips: Array of tips to show regardless of their display rule eligibility.
    public static func showTipsForTesting(_ tips: [any BackportTip.Type]) {
        fatalError()
    }

    /// Hide all tips regardless of their display rule eligibility for UI testing without tips.
    public static func hideAllTipsForTesting() {
        fatalError()
    }

    /// Hide specified tips regardless of their display rule eligibility for UI testing without certain tips.
    ///
    /// - Parameters:
    ///   - tips: Array of tips to hide regardless of their display rule eligibility.
    public static func hideTipsForTesting(_ tips: [any BackportTip.Type]) {
        fatalError()
    }
}

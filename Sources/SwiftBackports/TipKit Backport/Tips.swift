import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any> {
    @frozen public enum Tips { }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension Backport<Any>.Tips {
    private static var configured: Bool = false

    /// Called at app startup to load and configure the persistent state of all tips in your app:
    ///
    /// ```swift
    /// @main
    /// struct AppView: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .task {
    ///                     try? await Tips.configure {
    ///                         DisplayFrequency(.immediate)
    ///                         DatastoreLocation(.applicationDefault)
    ///                     }
    ///                 }
    ///         }
    ///     }
    /// }
    /// ```
    /// Configures an app's tips.
    ///
    /// - Parameters:
    ///   - options: An array of options for customizing your tip's datastore location and default frequency control interval.
    public static func configure(@BackportTipsConfigurationBuilder options: @Sendable @escaping () -> some BackportTipsConfiguration = { defaultConfiguration }) async throws {
        guard !configured else { throw Backport<Any>.TipKitError.tipsDatastoreAlreadyConfigured }
        let values = options() as? ConfigurationValues ?? .shared

        let manager = FileManager.default
        if values.datastoreLocation.shouldReset {
            if manager.fileExists(atPath: values.datastoreLocation.url.path) {
                try FileManager.default.removeItem(at: values.datastoreLocation.url)
            }
        }

        if !manager.fileExists(atPath: values.datastoreLocation.url.path) {
            try manager.createDirectory(at: values.datastoreLocation.url, withIntermediateDirectories: true)
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

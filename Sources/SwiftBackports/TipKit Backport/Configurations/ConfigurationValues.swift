import SwiftUI

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
internal struct ConfigurationValues: BackportTipsConfiguration, Sendable {
    /*
     I honestly don't know if this is a good idea, but its the easiest considering
     we're generally dealing with only a couple of options.

     The builder will essentially overwrite one or more of these properties
     based on the configuration at each step. Since TipKit is essentially a single
     instance only, we can make this a singleton to simplf the implementation
     */
    static var shared: ConfigurationValues = .init()
    private init() { }
    var analyticsEngine: AnalyticsEngine?
    var datastoreLocation: Backport<Any>.DatastoreLocation = .applicationDefault
    var displayFrequency: Backport<Any>.DisplayFrequency = .immediate
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
extension ConfigurationValues {
    mutating func update(with config: any BackportTipsConfiguration) {
        if let frequency = config as? Backport<Any>.DisplayFrequency {
            displayFrequency = frequency
        } else if let location = config as? Backport<Any>.DatastoreLocation {
            datastoreLocation = location
        }
    }
}

@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)
internal struct AnalyticsEngine { }

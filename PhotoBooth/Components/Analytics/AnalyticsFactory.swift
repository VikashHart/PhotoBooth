import Foundation
import Firebase

protocol EnvironmentProtocol {
    var analyticsEnabled: Bool { get }
}

struct Environment: EnvironmentProtocol {
    static let shared: Environment = Environment()
    let analyticsEnabled: Bool

    private init() {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: path) as! [AnyHashable: Any]
        let settings = plist["Settings"] as! [AnyHashable: Any]

        let analyticsString = settings["Analytics Enabled"] as! String
        analyticsEnabled = analyticsString == "YES"

        print("Analytics Enabled: \(analyticsEnabled)")
    }
}

protocol AnalyticsTracker {
    func configure()
    func logEvent(_ name: String, parameters: [String: Any])
}

class AnalyticsStore {
    static let store = AnalyticsStore()
    private var tracker: AnalyticsTracker = FirebaseAnalyticsTracker()

    static func get() -> AnalyticsTracker { return store.tracker }
}

class Analytics {
    static func logEvent(_ name: String, parameters: [String: Any]) {
        AnalyticsStore.get().logEvent(name, parameters: parameters)
    }
}

/*
 // To see analytics in debug console
 // go to Product>Schemes>Edit
 // check the -FIRAnalyticsDebugEnabled
 // checkbox in the Run section
 */

class FirebaseAnalyticsTracker: AnalyticsTracker {
    private var isActive: Bool {
        return Environment.shared.analyticsEnabled
    }

    func configure() {
        guard isActive else { return }
        FirebaseApp.configure()
    }

    func logEvent(_ name: String, parameters: [String : Any]) {
        guard isActive else { return }
        Firebase.Analytics.logEvent(name, parameters: parameters)
    }
}

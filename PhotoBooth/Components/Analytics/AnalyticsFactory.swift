import Foundation
import Firebase

protocol AnalyticsTracker {
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
        return Environment.shared.metricsEnabled
    }

    func logEvent(_ name: String, parameters: [String : Any]) {
        guard isActive else { return }
        Firebase.Analytics.logEvent(name, parameters: parameters)
    }
}

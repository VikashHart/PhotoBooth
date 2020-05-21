import Foundation
import Firebase

protocol MetricsTracker {
    func configureMetrics()
    func logEvent(_ name: String, parameters: [String: Any])
}

class MetricsStore {
    static let store = MetricsStore()
    private var tracker: MetricsTracker = FirebaseMetricsTracker()

    static func get() -> MetricsTracker { return store.tracker }
}

class Analytics {
    static func logEvent(_ name: String, parameters: [String: Any]) {
        MetricsStore.get().logEvent(name, parameters: parameters)
    }
}

/*
 // To see analytics in debug console
 // go to Product>Schemes>Edit
 // check the -FIRAnalyticsDebugEnabled
 // checkbox in the Run section
 */

class FirebaseMetricsTracker: MetricsTracker {
    private var isActive: Bool {
        return Environment.shared.productionEnabled
    }

    func configureMetrics() {
        guard isActive else { return }
        FirebaseApp.configure()
    }

    func logEvent(_ name: String, parameters: [String : Any]) {
        guard isActive else { return }
        Firebase.Analytics.logEvent(name, parameters: parameters)
    }
}

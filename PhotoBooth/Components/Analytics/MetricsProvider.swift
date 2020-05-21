import Foundation
import Firebase

protocol EnvironmentProtocol {
    var metricsEnabled: Bool { get }
    func configure()
}

struct Environment: EnvironmentProtocol {
    static let shared: Environment = Environment()
    let metricsEnabled: Bool

    private init() {
        #if DEBUG
        self.metricsEnabled = false
        #else
        self.metricsEnabled = true
        #endif

        print("""

            --- Metrics Enabled ---
            Analytics: \(metricsEnabled)
            Performance: \(metricsEnabled)

            """)
    }

    func configure() {
        guard metricsEnabled else { return }
        FirebaseApp.configure()
    }
}

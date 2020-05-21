import Foundation
import Firebase

protocol EnvironmentProtocol {
    var productionEnabled: Bool { get }
}

struct Environment: EnvironmentProtocol {
    static let shared: Environment = Environment()
    let productionEnabled: Bool

    private init() {
        #if DEBUG
        self.productionEnabled = false
        #else
        self.productionEnabled = true
        #endif

        print("""

            --- Metrics Enabled ---
            Analytics: \(productionEnabled)
            Performance: \(productionEnabled)

            """)
    }
}

import Foundation
import Firebase

protocol EnvironmentProtocol {
    var productionEnabled: Bool { get }
}

struct Environment: EnvironmentProtocol {
    static let shared: Environment = Environment()
    let productionEnabled: Bool
    private let environment: String

    private init() {
        #if DEBUG
        self.productionEnabled = false
        #else
        self.productionEnabled = true
        #endif

        switch productionEnabled {
        case true:
            self.environment = "Production"
        case false:
            self.environment = "Development"
        }

        print("""

            --- Services ---
            RemoteConfig Environment: \(environment)

            """)
    }
}

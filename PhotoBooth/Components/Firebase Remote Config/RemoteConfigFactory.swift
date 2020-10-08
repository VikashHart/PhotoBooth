import Foundation
import Firebase

class RemoteConfigStore {
    static let configStore = RemoteConfigStore()

    private var isActive: Bool {
        return Environment.shared.productionEnabled
    }
    var loadComplete: Bool
    var loadingDidComplete: (() -> Void)?
    var loadingDidFail: (() -> Void)?
    var configPayload: [RCPayload] = []
    private var defaults: [String : Any] = [
        "rcPayload":"",
        "performanceEnabledAuto": true,
        "performanceEnabledCustom": true,
        "analyticsEnabled": true
    ]

    private let client: RCPayloadRetrievable

    private var fetchInterval: TimeInterval {
        switch isActive {
        case true:
            return 43200 // About 12 hours in seconds
        case false:
            return 0
        }
    }

    private init(
        client: RCPayloadRetrievable = RCPayloadClient(),
        loadComplete: Bool = false) {
        self.client = client
        self.loadComplete = loadComplete
        loadDefaultValues()
        switch isActive {
        case true:
            fetchCloudValues()
        case false:
            self.loadComplete = true
        }
    }

    private func getRCDefaults() {
        let data: NSData = RemoteConfig.remoteConfig()["rcPayload"].dataValue as NSData
        self.client.getPayload(data: data) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.configPayload = data
                self?.setAnalyticsCollection()
                self?.setPerformanceCollection()
                self?.loadComplete = true
                self?.loadingDidComplete?()
            case .failure(let error):
                print(error.localizedDescription)
                self?.loadingDidFail?()
            }
        }
    }

    func setAnalyticsCollection() {
        if fetchAnalyticsEnabled() {
            Analytics.enableAnalytics(value: true)
        } else {
            Analytics.enableAnalytics(value: false)
        }
    }

    private func setPerformanceCollection() {
        if fetchPerformanceAutoEnabled() {
            Performance.sharedInstance().isInstrumentationEnabled = true
        } else {
            Performance.sharedInstance().isInstrumentationEnabled = false
        }

        if fetchPerformanceCustomEnabled() {
            Performance.sharedInstance().isDataCollectionEnabled = true
        } else {
            Performance.sharedInstance().isDataCollectionEnabled = false
        }
    }

    func fetchPerformanceAutoEnabled() -> Bool {
        return RemoteConfig.remoteConfig()["performanceEnabledAuto"].boolValue
    }

    func fetchPerformanceCustomEnabled() -> Bool {
        return RemoteConfig.remoteConfig()["performanceEnabledCustom"].boolValue
    }

    func fetchAnalyticsEnabled() -> Bool {
        return RemoteConfig.remoteConfig()["analyticsEnabled"].boolValue
    }

    private func loadDefaultValues() {
        RemoteConfig.remoteConfig().setDefaults(defaults as? [String : NSObject])
    }

    func fetchCloudValues() {
        activateDebugMode()

        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchInterval) { [weak self] (status, error) in
            if status == .success {
                RemoteConfig.remoteConfig().activate { (success, error) in
                    if success {
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            } else if let error = error {
                print ("Uh-oh. Got an error fetching remote values \(error)")
                self?.loadingDidFail?()
                // In a real app, you would probably want to call the loading done callback anyway,
                // and just proceed with the default values. I won't do that here, so we can call attention
                // to the fact that Remote Config isn't loading.
                return
            }
            self?.getRCDefaults()
        }
    }

    private func activateDebugMode() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = fetchInterval
        settings.fetchTimeout = 5
        RemoteConfig.remoteConfig().configSettings = settings
    }
}

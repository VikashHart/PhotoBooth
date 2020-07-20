import Foundation
import Firebase

class RemoteConfigStore {
    static let configStore = RemoteConfigStore()

    private var isActive: Bool {
        return Environment.shared.productionEnabled
    }
    var loadComplete: Bool
    var loadingDoneCallback: (() -> Void)?
    var configPayload: [RCPayload] = []
    private var defaults: [String : Any] = [
        "rcPayload":"",
        "performanceDisableAuto": false,
        "performanceDisableCustom": false,
        "analyticsDisable": false]
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
        fetchCloudValues()
    }

    private func getRCDefaults() {
        guard let data = RemoteConfig.remoteConfig()["rcPayload"].dataValue as? NSData else { return }
        self.client.getPayload(data: data) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.configPayload = data
                self?.setAnalyticsCollection()
                self?.setPerformanceCollection()
                self?.loadComplete = true
                self?.loadingDoneCallback?()
            case .failure(let error):
                print(error.localizedDescription)
                self?.loadingDoneCallback?()
            }
        }
    }

    func setAnalyticsCollection() {
        if fetchAnalyticsDisabled() {
            Analytics.enableAnalytics(value: false)
        } else {
            Analytics.enableAnalytics(value: true)
        }
    }

    private func setPerformanceCollection() {
        if fetchPerformanceAutoDisabled() {
            Performance.sharedInstance().isInstrumentationEnabled = false
        } else {
            Performance.sharedInstance().isInstrumentationEnabled = true
        }

        if fetchPerformanceCustomDisabled() {
            Performance.sharedInstance().isDataCollectionEnabled = false
        } else {
            Performance.sharedInstance().isDataCollectionEnabled = true
        }
    }

    func fetchPerformanceAutoDisabled() -> Bool {
        return RemoteConfig.remoteConfig()["performanceDisableAuto"].boolValue
    }

    func fetchPerformanceCustomDisabled() -> Bool {
        return RemoteConfig.remoteConfig()["performanceDisableCustom"].boolValue
    }

    func fetchAnalyticsDisabled() -> Bool {
        return RemoteConfig.remoteConfig()["analyticsDisable"].boolValue
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

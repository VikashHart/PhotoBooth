import Foundation

protocol InterstitialVCViewModeling {
    func showUpdate() -> Bool
    func getUpdateConfiguraion() -> UpdateConfiguration
    func postLaterSelected()
    func postOkaySelected()
    func postUpdateSelected()
}

class InterstitialVCViewModel: InterstitialVCViewModeling {

    private var deviceInfo: DeviceProcessInfoProviding

    init(deviceInfo: DeviceProcessInfoProviding = DeviceProcessInfo()) {
        self.deviceInfo = deviceInfo
    }

    func showUpdate() -> Bool {
        guard let payload = RemoteConfigStore.configStore.configPayload.first else { return false }
        switch deviceInfo.appVersion() == payload.currentVersion {
        case true:
            return false
        case false:
            return true
        }
    }

    func getUpdateConfiguraion() -> UpdateConfiguration {
        var configuration: UpdateConfiguration = .none

        if versionSupported() && osSupported() {
            configuration = .laterAndUpdate
        } else if versionSupported() && !osSupported() {
            configuration = .okay
        } else if !versionSupported() && osSupported() {
            configuration = .update
        } else if !versionSupported() && !osSupported() {
            configuration = .none
        }

        return configuration
    }

    func postLaterSelected() {
        let parameters = ["vc_identifier" : ViewControllerIdentifier.interstitial.rawValue]
        Analytics.logEvent("later_selected", parameters: parameters)
    }

    func postOkaySelected() {
        let parameters = ["vc_identifier" : ViewControllerIdentifier.interstitial.rawValue]
        Analytics.logEvent("okay_selected", parameters: parameters)
    }

    func postUpdateSelected() {
        let parameters = ["vc_identifier" : ViewControllerIdentifier.interstitial.rawValue]
        Analytics.logEvent("update_selected", parameters: parameters)
    }

    private func versionSupported() -> Bool {
        var isSupported = false
        guard let payload = RemoteConfigStore.configStore.configPayload.first else { return false }

        if deviceInfo.appVersion() >= payload.minSupportedVersion &&
            !payload.blacklist.contains(deviceInfo.appVersion()) {
            isSupported = true
        } else {
            isSupported = false
        }

        return isSupported
    }

    private func osSupported() -> Bool {
        var isSupported = false
        guard let payload = RemoteConfigStore.configStore.configPayload.first else { return false }

        if deviceInfo.OSVersion() >= payload.minSupportediOSVersion {
            isSupported = true
        } else {
            isSupported = false
        }

        return isSupported
    }
}

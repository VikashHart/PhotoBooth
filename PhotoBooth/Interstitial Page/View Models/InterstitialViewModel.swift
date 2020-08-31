import Foundation

protocol InterstitialViewModeling {
    var versionText: String { get }
}

class InterstitialViewModel: InterstitialViewModeling {
    var versionText: String

    init(deviceInfo: DeviceProcessInfoProviding = DeviceProcessInfo()) {
        self.versionText = "v\(deviceInfo.appVersion().description)"
    }
}

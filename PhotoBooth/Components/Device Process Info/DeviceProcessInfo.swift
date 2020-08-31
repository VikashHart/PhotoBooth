import Foundation
import UIKit

protocol DeviceProcessInfoProviding {
    func OSVersion() -> Version
    func appVersion() -> Version
}

class DeviceProcessInfo: DeviceProcessInfoProviding {
    func OSVersion() -> Version {
        return Version(versionString: UIDevice.current.systemVersion)
    }

    func appVersion() -> Version {
        guard let releaseVersion = Bundle.main.releaseVersionNumber else { fatalError("Could not retrieve app release version number")}
        return Version(versionString: releaseVersion)
    }
}

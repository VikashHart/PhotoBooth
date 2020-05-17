import Foundation
import AVFoundation

class AVAuthorizationFactory: AVAuthorization {
    func getAVAuthorizationStatus() -> Bool {
        return cameraAuthorizationStatusCheck()
    }

    private func cameraAuthorizationStatusCheck() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied, .restricted, .notDetermined:
            return false
        case .authorized:
            return true
        @unknown default:
            return false
        }
        #endif
    }
}

import UIKit

extension UIDeviceOrientation {
    var orientationCategory: String {
        switch self {
        case .landscapeLeft, .landscapeRight:
            return "landscape"
        case .portrait, .portraitUpsideDown:
            return "portrait"
        case .faceUp, .faceDown:
            return "flat"
        case .unknown:
            return "unknown"
        }
    }
}

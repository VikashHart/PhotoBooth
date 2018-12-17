import UIKit
import AVFoundation

enum ImageOrientation {
    case landscape
    case portrait

    init(size: CGSize) {
        if size.width <= size.height {
            self = .portrait
        } else {
            self = .landscape
        }
    }

    var description: String {
        switch self {
        case .landscape:
            return "landscape"
        case .portrait:
            return "portrait"
        }
    }
}

struct ProcessedImage {
    let image: UIImage
    let cameraPosition: AVCaptureDevice.Position

    init(image: UIImage, cameraPosition: AVCaptureDevice.Position) {
        self.image = image
        self.cameraPosition = cameraPosition
    }
}

extension UIImage {
    var orientation: ImageOrientation {
        return ImageOrientation(size: size)
    }
}

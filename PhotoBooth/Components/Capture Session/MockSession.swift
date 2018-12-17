import UIKit
import AVFoundation

class MockSession: PhotoCaptureable {
    func updateOrientation(orientation: AVCaptureVideoOrientation) {
    }

    var onImageCaptured: ((ProcessedImage) -> Void)?

    let mockImage = UIImage()
    
    func captureImage() {
        DispatchQueue.main.async {
            self.onImageCaptured?(ProcessedImage(image: UIImage(named: "sim_default")!, cameraPosition: .front) )
        }
    }

    func configurePreview(view: AVCapturePreviewView) {
        view.backgroundColor = .purple
    }
    
    func switchCamera() {
    }
}

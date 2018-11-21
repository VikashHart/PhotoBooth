import UIKit

class MockSession: PhotoCaptureable {
    var onImageCaptured: ((UIImage) -> Void)?

    let mockImage = UIImage()
    
    func captureImage() {
        DispatchQueue.main.async {
            self.onImageCaptured?(UIImage())
        }
    }

    func configurePreview(view: AVCapturePreviewView) {
        view.backgroundColor = .purple
    }
    
    func switchCamera() {
    }
}

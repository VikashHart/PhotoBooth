import UIKit

class MockSession: PhotoCaptureable {
    let mockImage = UIImage()
    
    func captureImage() -> UIImage {
        return UIImage()
    }
    
    func configurePreview(view: AVCapturePreviewView) {
        
    }
    
    func switchCamera() {
        
    }
}

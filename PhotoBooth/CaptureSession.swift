import UIKit

protocol ImageCapturing {
    
    func getImage() -> UIImage
    
    func configurePreview(view: UIView)
}

class CaptureSession: ImageCapturing {
    
    func getImage() -> UIImage {
        return UIImage()
    }
    
    func configurePreview(view: UIView) {
        
    }
}

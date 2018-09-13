import UIKit

protocol PhotoCaptureable {
    
    func getPhotos() -> UIImage
    
    func configurePreview(view: UIView)
}

class CaptureSession: PhotoCaptureable {
    
    func getPhotos() -> UIImage {
        
    }
    
    func configurePreview(view: UIView) {
        
    }
}

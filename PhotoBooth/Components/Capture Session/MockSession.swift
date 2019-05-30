import UIKit
import AVFoundation

class MockSession: PhotoCaptureable {
    func getFlashMode() -> AVCaptureDevice.FlashMode {
        return .off
    }
    func minMaxZoom(_ factor: CGFloat) -> CGFloat {
        return CGFloat()
    }
    func setFlashMode(mode: FlashModeOption) {
    }
    func focus(touchLocation: CGPoint) {
    }
    func updateZoomScaleFactor(scale factor: CGFloat) {
    }
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

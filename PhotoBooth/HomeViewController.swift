import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    let cameraView = CameraView()
    let captureSession = CaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cameraView)
        captureSession.setupCaptureSession()
        cameraView.switchCameraButton.addTarget(self,
                                                action: #selector(captureSession.changeCamera(sender:)),
                                                for: .touchUpInside)
        setupDownSwipeGesture()
    }

    private func setupDownSwipeGesture() {
        let down = UISwipeGestureRecognizer(target : self, action : #selector(cancelPhotoBoothSession))
        down.direction = .down
        self.cameraView.addGestureRecognizer(down)
    }
    
    @objc func cancelPhotoBoothSession() {
        
    }

}

extension HomeViewController: UIGestureRecognizerDelegate {
    
}

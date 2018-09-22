import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    let captureSession: PhotoCaptureable = CaptureSession()
    
    lazy var previewLayerContainer: UIView = {
        let pl = UIView()
        pl.translatesAutoresizingMaskIntoConstraints = false
        return pl
    }()
    
    lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "rotate_camera")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    var image: UIImage?
    var filmStrip = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        captureSession.configurePreview(view: previewLayerContainer)
        self.switchCameraButton.addTarget(self,
                                                action: #selector(rotateCamera),
                                                for: .touchUpInside)
        setupDownSwipeGesture()
    }

    private func setupDownSwipeGesture() {
        let down = UISwipeGestureRecognizer(target : self, action : #selector(cancelPhotoBoothSession))
        down.direction = .down
        self.view.addGestureRecognizer(down)
    }
    
    @objc func rotateCamera() {
        captureSession.switchCamera()
    }
    
    @objc func cancelPhotoBoothSession() {
        
    }
    
    private func setupViews() {
        setupPreviewLayerContainer()
        setupSwitchCameraButton()
    }
    
    private func setupPreviewLayerContainer() {
        view.addSubview(previewLayerContainer)
        NSLayoutConstraint.activate([
            previewLayerContainer.topAnchor.constraint(equalTo: view.topAnchor),
            previewLayerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewLayerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewLayerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func setupSwitchCameraButton() {
        previewLayerContainer.addSubview(switchCameraButton)
        NSLayoutConstraint.activate([
            switchCameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            switchCameraButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            switchCameraButton.widthAnchor.constraint(equalToConstant: 40),
            switchCameraButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

}

extension CameraViewController: UIGestureRecognizerDelegate {
    
}

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    private let captureSession: PhotoCaptureable = CaptureSession()
    
    lazy var previewLayerContainer: AVCapturePreviewView = {
        let pl = AVCapturePreviewView()
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

    private var capturedImages = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        captureSession.configurePreview(view: previewLayerContainer)
        self.switchCameraButton.addTarget(self,
                                                action: #selector(rotateCamera),
                                                for: .touchUpInside)
        setupDownSwipeGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presentConfigurationCard()
    }

    private func presentConfigurationCard() {
        let cardVC = SetupCardViewController()
        cardVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(cardVC, animated: true, completion: nil)
    }

    private func setupDownSwipeGesture() {
        let down = UISwipeGestureRecognizer(target : self, action : #selector(cancelPhotoBoothSession))
        down.direction = .down
        self.view.addGestureRecognizer(down)
    }
    
    @objc private func rotateCamera() {
        captureSession.switchCamera()
    }
    
    @objc private func cancelPhotoBoothSession() {
        
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
            switchCameraButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            switchCameraButton.widthAnchor.constraint(equalToConstant: 40),
            switchCameraButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

}

extension CameraViewController: UIGestureRecognizerDelegate {
    
}

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    private let captureSession: PhotoCaptureable = PhotoCaptureableFactory.getPhotoCapturable()

    lazy var previewLayerContainer: AVCapturePreviewView = {
        let pl = AVCapturePreviewView()
        pl.translatesAutoresizingMaskIntoConstraints = false
        return pl
    }()

    lazy var countdownView: UIView = {
        let view = CountdownIndicatorView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    lazy var middlePrompt: PromptView = {
        let pv = PromptView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.alpha = 0
        return pv
    }()

    private var numberOfPhotos = Int()
    private var timerDelay = TimeInterval()

    private var capturedImages = [UIImage]()

    //Mark:- override functions
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = UIDevice.current.orientation
        let connection = previewLayerContainer.avPreviewLayer.connection
        switch orientation {
        case .portrait: connection?.videoOrientation = .portrait
        case .landscapeLeft: connection?.videoOrientation = .landscapeRight
        case .landscapeRight: connection?.videoOrientation = .landscapeLeft
        case .portraitUpsideDown: connection?.videoOrientation = .portraitUpsideDown
        default: break
        }
    }

    private func presentConfigurationCard() {
        let setupCardPartialModal = SetUpCardPartialModal(onConfigureFinalized: { [weak self] configuration, modal in
            modal.dismiss()
            self?.beginShoot(config: configuration)
        })
        middlePrompt.present(modal: setupCardPartialModal, animated: false)
    }

    private func beginShoot(config: PhotoShootConfiguration) {

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
        setupCountdownView()
        setupSwitchCameraButton()
        setUpMiddlePromptContainer()
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

    private func setupCountdownView() {
        previewLayerContainer.addSubview(countdownView)
        NSLayoutConstraint.activate([
            countdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            countdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countdownView.widthAnchor.constraint(equalToConstant: 40),
            countdownView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    private func setupSwitchCameraButton() {
        previewLayerContainer.addSubview(switchCameraButton)
        NSLayoutConstraint.activate([
            switchCameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            switchCameraButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            switchCameraButton.widthAnchor.constraint(equalToConstant: 40),
            switchCameraButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setUpMiddlePromptContainer() {
        view.addSubview(middlePrompt)
        NSLayoutConstraint.activate([
            middlePrompt.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            middlePrompt.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor),
            middlePrompt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            middlePrompt.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension CameraViewController: UIGestureRecognizerDelegate {
    
}

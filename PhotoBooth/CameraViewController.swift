import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    var viewModel: CameraViewControllerViewModeling = CameraViewControllerViewModel()

    lazy var previewLayerContainer: AVCapturePreviewView = {
        let pl = AVCapturePreviewView()
        pl.translatesAutoresizingMaskIntoConstraints = false
        return pl
    }()

    lazy var countdownView: CountdownIndicatorView = {
        let viewModel = CountdownIndicatorViewModel()
        let view = CountdownIndicatorView(viewModel: viewModel)
        view.backgroundColor = .clear
        view.isHidden = true
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

    //Mark:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.captureSession.configurePreview(view: previewLayerContainer)
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
            self?.configureShoot(config: configuration)
            self?.presentSwipeToCancelPrompt()
        })
        middlePrompt.present(modal: setupCardPartialModal, animated: false)
    }

    private func presentSwipeToCancelPrompt() {
        let cancelPrompt = SwipeToCancelPromptPartialModal()
        middlePrompt.present(modal: cancelPrompt, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            cancelPrompt.dismiss()
            self.startShoot()
        }
    }

    private func configureShoot(config: PhotoShootConfiguration) {
        viewModel.setupShoot(with: config) { [weak self] timeRemaining in

            if timeRemaining != 0 {
                self?.countdownView.updateWith(timeRemaining: timeRemaining, animated: true)
            } else {
                self?.countdownView.updateWith(timeRemaining: timeRemaining, animated: false)
            }
        }
    }

    private func presentReviewPage(images: [UIImage]) {
        let reviewVC = ModalReviewViewController(capturedImages: images)
        present(reviewVC, animated: true, completion: nil)
        viewModel.reset()
        countdownView.isHidden = true
    }

    private func startShoot() {
        countdownView.isHidden = false
        viewModel.startShoot(onComplete: { [weak self] capturedImages in
            self?.presentReviewPage(images: capturedImages)
        })
    }

    private func setupDownSwipeGesture() {
        let down = UISwipeGestureRecognizer(target : self, action : #selector(cancelPhotoBoothSession))
        down.direction = .down
        self.view.addGestureRecognizer(down)
    }
    
    @objc private func rotateCamera() {
        viewModel.captureSession.switchCamera()
    }
    
    @objc private func cancelPhotoBoothSession() {
        viewModel.timer?.stopTimer()
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

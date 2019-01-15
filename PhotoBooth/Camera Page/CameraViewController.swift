import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    lazy var viewModel: CameraViewControllerViewModeling = {
        let viewModel = CameraViewControllerViewModel() {
            [weak self] in
            self?.presentConfigurationCard()
            self?.countdownView.isHidden = true
        }

        viewModel.onCountdownComplete = { [weak self] in
            self?.flashViewAnimate()
        }

        return viewModel
    }()

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
        return pv
    }()

    lazy var flashView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        view.alpha = 0
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        super.viewDidAppear(animated)
        presentConfigurationCard()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = UIDevice.current.orientation
        let connection = previewLayerContainer.avPreviewLayer.connection

        guard let videoOrientation = AVCaptureVideoOrientation(deviceOrientation: orientation)
            else { return }
        connection?.videoOrientation = videoOrientation
        viewModel.captureSession.updateOrientation(orientation: videoOrientation)
    }

    private func requestCameraAccess() {
        let alertController = UIAlertController(title: "Looks like camera access is denied",
                                                message: "In order to take pictures Lens needs access to your camera. To update your app permissions, click settings below.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })

        present(alertController, animated: true)
    }

    private func presentConfigurationCard() {
        let setupCardPartialModal = SetUpCardPartialModal(onConfigureFinalized: { [weak self] configuration, modal in
            guard let strongSelf = self else { return }
            if strongSelf.viewModel.checkCameraAccess() {
                modal.dismiss()
                self?.configureShoot(config: configuration)
                self?.presentSwipeToCancelPrompt()
            } else {
                self?.requestCameraAccess()
            }
        })
        middlePrompt.present(modal: setupCardPartialModal, animated: false)
    }

    private func presentSwipeToCancelPrompt() {
        let cancelPrompt = SwipeToCancelPromptPartialModal()
        middlePrompt.present(modal: cancelPrompt, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            cancelPrompt.dismiss()
            self.startShoot()
        }
    }

    private func presentCancelationPartialModal() {
        let cancelModal = SwipeToCancelPartialModal(numberOfPhotos: viewModel.capturedImages.count) {
            [weak self] action, modal in
            modal.dismiss()
            self?.viewModel.processCancellationAction(action: action)
        }
        middlePrompt.present(modal: cancelModal, animated: true)
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

    private func presentReviewPage(data: PhotoShootData) {
        let reviewVC = ReviewViewController(data: data)
        present(reviewVC, animated: true, completion: nil)
        viewModel.reset()
        countdownView.isHidden = true
    }

    private func startShoot() {
        countdownView.isHidden = false
        viewModel.startShoot(onComplete: { [weak self] data in
            self?.presentReviewPage(data: data)
        })
    }

    private func setupDownSwipeGesture() {
        let down = UISwipeGestureRecognizer(target : self, action : #selector(cancelPhotoBoothSession))
        down.direction = .down
        self.view.addGestureRecognizer(down)
        down.delegate = self
    }

    private func flashViewAnimate() {
        UIView.animate(withDuration: 0.2, animations: {
            self.flashView.isHidden = false
            self.flashView.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.flashView.alpha = 0
                self.flashView.isHidden = true
            }
        }
    }
    
    @objc private func rotateCamera() {
        viewModel.captureSession.switchCamera()
    }
    
    @objc private func cancelPhotoBoothSession() {
        viewModel.timer?.stopTimer()
        if viewModel.capturedImages.count == 0 {
            viewModel.reset()
            countdownView.isHidden = true
            presentConfigurationCard()
        } else {
            presentCancelationPartialModal()
        }
    }
    
    private func setupViews() {
        setupPreviewLayerContainer()
        setupCountdownView()
        setupSwitchCameraButton()
        setUpMiddlePromptContainer()
        setupFlashView()
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

    private func setupFlashView() {
        view.addSubview(flashView)
        NSLayoutConstraint.activate([
            flashView.topAnchor.constraint(equalTo: view.topAnchor),
            flashView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flashView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flashView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension CameraViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if !viewModel.cancelEnabled {
            postInvalidSwipeEvent()
        }
        return viewModel.cancelEnabled
    }

    private func postInvalidSwipeEvent() {
        Analytics.logEvent("invalid_swipe_event",
                           parameters: viewModel.photoShootConfiguration?.parameters ?? [:])
    }
}

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    //MARK: - View Model
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

    //MARK: - Preview Layer
    lazy var previewLayerContainer: AVCapturePreviewView = {
        let pl = AVCapturePreviewView()
        pl.translatesAutoresizingMaskIntoConstraints = false
        return pl
    }()

    //MARK: - UI Objects
    lazy var countdownView: CountdownIndicatorView = {
        let viewModel = CountdownIndicatorViewModel()
        let view = CountdownIndicatorView(viewModel: viewModel)
        view.backgroundColor = .clear
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var flashContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.addBlurEffect(blurStyle: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var flashButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: StyleGuide.Assets.flashOff)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var rotateContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.addBlurEffect(blurStyle: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: StyleGuide.Assets.rotateCamera)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
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

    //MARK:- Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.configurePreview(view: previewLayerContainer)
        setupDownSwipeGesture()
        setupButtons()
        configureGestures()
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
        viewModel.updateOrientation(orientation: videoOrientation)
    }

    //MARK: - Camera Access Alert
    private func presentMissingCameraAccessAlert() {
        let alertController = UIAlertController(title: StyleGuide.AppCopy.CameraVC.missingCameraAccessTitle,
                                                message: StyleGuide.AppCopy.CameraVC.missingCameraAccessMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: StyleGuide.AppCopy.CameraVC.rhAlertButtonText, style: .destructive))
        alertController.addAction(UIAlertAction(title: StyleGuide.AppCopy.CameraVC.lhAlertButtonText, style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        })

        present(alertController, animated: true)
    }

    //MARK: - Modal Presentation
    private func presentConfigurationCard() {
        let setupCardPartialModal = SetUpCardPartialModal(onConfigureFinalized: { [weak self] configuration, modal in
            guard let strongSelf = self else { return }
            if strongSelf.viewModel.permissionStatus {
                modal.dismiss()
                strongSelf.configureShoot(config: configuration)
                strongSelf.presentSwipeToCancelPrompt()
            } else {
                strongSelf.presentMissingCameraAccessAlert()
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
        reviewVC.modalPresentationStyle = .fullScreen
        present(reviewVC, animated: true, completion: nil)
        viewModel.reset()
        countdownView.isHidden = true
    }

    //MARK: - Camera Functionality
    private func startShoot() {
        countdownView.isHidden = false
        viewModel.startShoot(onComplete: { [weak self] data in
            self?.presentReviewPage(data: data)
        })
    }

    private func animateFocus(touchPoint: CGPoint, previewLayer: AVCapturePreviewView) {
        var focusSquare: FocusAnimating?

        if let fsquare = focusSquare {
            fsquare.updatePoint(touchPoint)
        }else{
            focusSquare = CameraFocusSquare(touchPoint: touchPoint)
            previewLayer.addSubview(focusSquare as! UIView)
            focusSquare?.refreshUI()
        }

        focusSquare?.animateFocusingAction()
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

    @objc func flashMode() {
        var flashImage = UIImage()
        switch viewModel.flashType {
        case .on:
            guard let offImage = UIImage(named: StyleGuide.Assets.flashOff) else { return }
            flashImage = offImage
        case .off:
            guard let onImage = UIImage(named: StyleGuide.Assets.flashOn) else { return }
            flashImage = onImage
        }

        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.flashContainer.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                        self.viewModel.toggleFlash()
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.flashButton.setImage(flashImage, for: .normal)
                            self.flashContainer.transform = CGAffineTransform.identity
                        }
        })
    }

    @objc private func rotateCamera() {
        self.viewModel.switchCamera()
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.switchCameraButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.switchCameraButton.transform = CGAffineTransform.identity
                        }
        })
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

    //MARK: - Gestures
    private func setupDownSwipeGesture() {
        let down = UISwipeGestureRecognizer(target : self, action : #selector(cancelPhotoBoothSession))
        down.direction = .down
        self.view.addGestureRecognizer(down)
        down.delegate = self
    }

    @objc func handleSingleTap(tapGesture: UITapGestureRecognizer) {
        let point = tapGesture.location(in: self.previewLayerContainer)
        animateFocus(touchPoint: point, previewLayer: self.previewLayerContainer)
        viewModel.focus(touchLocation: point)
    }

    @objc func handleDoubleTap() {
        viewModel.switchCamera()
    }

    @objc func pinch(_ pinch: UIPinchGestureRecognizer) {
        let newScaleFactor = viewModel.minMaxZoom(pinch.scale * viewModel.zoomFactor)

        switch pinch.state {
        case .began: fallthrough
        case .changed: viewModel.updateZoomScaleFactor(scale: newScaleFactor)
        case .ended:
            viewModel.updateZoomFactor(factor: newScaleFactor)
            viewModel.updateZoomScaleFactor(scale: newScaleFactor)
        default: break
        }
    }

    private func setupButtons() {
        switchCameraButton.addTarget(self,
                                     action: #selector(rotateCamera),
                                     for: .touchUpInside)
        flashButton.addTarget(self,
                              action: #selector(flashMode),
                              for: .touchUpInside)
    }

    private func configureGestures() {
        // Single Tap
        let singleTap: UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(tapGesture:)))
        singleTap.numberOfTapsRequired = 1
        previewLayerContainer.addGestureRecognizer(singleTap)

        // Double Tap
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        previewLayerContainer.addGestureRecognizer(doubleTap)

        singleTap.require(toFail: doubleTap)
        singleTap.delaysTouchesBegan = true
        doubleTap.delaysTouchesBegan = true

        let pinchToZoom: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        previewLayerContainer.addGestureRecognizer(pinchToZoom)
    }

    //MARK: - Configure Subviews
    private func setupViews() {
        setupPreviewLayerContainer()
        setupCountdownView()
        setupFlashContainer()
        setupFlashButton()
        setupRotateContainer()
        setupSwitchCameraButton()
        setUpMiddlePromptContainer()
        setupFlashView()
    }

    //MARK: - Constraints
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

    private func setupFlashContainer() {
        previewLayerContainer.addSubview(flashContainer)
        NSLayoutConstraint.activate([
            flashContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            flashContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            flashContainer.heightAnchor.constraint(equalToConstant: 50),
            flashContainer.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupFlashButton() {
        flashContainer.addSubview(flashButton)
        NSLayoutConstraint.activate([
            flashButton.topAnchor.constraint(equalTo: flashContainer.topAnchor),
            flashButton.leadingAnchor.constraint(equalTo: flashContainer.leadingAnchor),
            flashButton.trailingAnchor.constraint(equalTo: flashContainer.trailingAnchor),
            flashButton.bottomAnchor.constraint(equalTo: flashContainer.bottomAnchor),
            flashButton.heightAnchor.constraint(equalToConstant: 40),
            flashButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupRotateContainer() {
        previewLayerContainer.addSubview(rotateContainer)
        NSLayoutConstraint.activate([
            rotateContainer.bottomAnchor.constraint(equalTo: flashContainer.topAnchor, constant: -8),
            rotateContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            rotateContainer.heightAnchor.constraint(equalToConstant: 50),
            rotateContainer.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupSwitchCameraButton() {
        rotateContainer.addSubview(switchCameraButton)
        NSLayoutConstraint.activate([
            switchCameraButton.topAnchor.constraint(equalTo: rotateContainer.topAnchor),
            switchCameraButton.leadingAnchor.constraint(equalTo: rotateContainer.leadingAnchor),
            switchCameraButton.trailingAnchor.constraint(equalTo: rotateContainer.trailingAnchor),
            switchCameraButton.bottomAnchor.constraint(equalTo: rotateContainer.bottomAnchor),
            switchCameraButton.heightAnchor.constraint(equalToConstant: 40),
            switchCameraButton.widthAnchor.constraint(equalToConstant: 40)
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

//MARK: - Gesture Recognizer Delegate
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

//MARK: - Swift Migrator Function
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

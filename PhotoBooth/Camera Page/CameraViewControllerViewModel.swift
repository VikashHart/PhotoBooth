import Foundation
import UIKit
import AVFoundation

protocol CameraViewControllerViewModeling {
    var permissionStatus: Bool { get }
    var timer: TimerModeling? { get }
    var numberOfPhotos: Int { get }
    var capturedImages: [UIImage] { get }
    var zoomFactor: CGFloat { get }
    var cancelEnabled: Bool { get }
    var flashType: FlashStatus { get }
    var photoShootConfiguration: PhotoShootConfiguration? { get }
    var onStartNewShoot: () -> Void { get }
    var onCountdownComplete: (() -> Void)? { get set }

    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void)
    func startShoot(onComplete: @escaping ((PhotoShootData) -> Void))
    func reset()
    func processCancellationAction(action: CancellationAction)
    func updateZoomFactor(factor: CGFloat)
    func toggleFlash()
    func configurePreview(view: AVCapturePreviewView)
    func updateOrientation(orientation: AVCaptureVideoOrientation)
    func switchCamera()
    func focus(touchLocation: CGPoint)
    func minMaxZoom(_ factor: CGFloat) -> CGFloat
    func updateZoomScaleFactor(scale factor: CGFloat)
}

class CameraViewControllerViewModel: CameraViewControllerViewModeling {
    private(set) var captureSession: PhotoCaptureable
    var permissionStatus: Bool {
        authorizationProvider.getAVAuthorizationStatus()
    }
    private(set) var timer: TimerModeling?
    private(set) var numberOfPhotos: Int = 0
    private(set) var capturedImages = [UIImage]()
    private(set) var zoomFactor: CGFloat = 1.0
    private(set) var cancelEnabled: Bool = false
    private(set) var flashType: FlashStatus = .off
    private var onShootComplete: ((PhotoShootData) -> Void)?
    private(set) var photoShootConfiguration: PhotoShootConfiguration?
    let onStartNewShoot: () -> Void
    var onCountdownComplete: (() -> Void)?
    private let authorizationProvider: AVAuthorization

    init(captureSession: PhotoCaptureable = PhotoCaptureableFactory.getPhotoCapturable(),
         authorizationProvider: AVAuthorization = AVAuthorizationProvider(),
         onStartNewShoot: @escaping () -> Void) {
        self.captureSession = captureSession
        self.authorizationProvider = authorizationProvider
        self.onStartNewShoot = onStartNewShoot
        self.captureSession.onImageCaptured = { [weak self] processedImage in
            self?.postImageCapturedEvent(processedImage: processedImage)
            self?.processImage(image: processedImage.image)
        }
    }

    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void) {
        Analytics.logEvent("setup_complete", parameters: [
            "vc_identifier" : ViewControllerIdentifier.camera.rawValue,
            "photo_count" : config.photoCount,
            "time_interval" : config.timeInterval])
        photoShootConfiguration = config
        numberOfPhotos = config.photoCount
        timer = CountdownTimer(seconds: config.timeInterval,
                               onTimerUpdate: { [weak self] timeRemaining in
                                if timeRemaining == 0 {
                                    self?.capturePhoto()
                                }
                                onTimerUpdated(timeRemaining)
        })
    }

    func startShoot(onComplete: @escaping ((PhotoShootData) -> Void)) {
        onShootComplete = onComplete
        timer?.startTimer()
        cancelEnabled = true
    }

    func reset() {
        self.timer = nil
        self.numberOfPhotos = 0
        self.capturedImages = [UIImage]()
        self.zoomFactor = 1.0
        self.cancelEnabled = false
    }

    func processCancellationAction(action: CancellationAction) {
        postCancellationEvent(action: action)

        switch action {
        case .review:
            onShootComplete?(getPhotoShootData())
        case .discard:
            reset()
            onStartNewShoot()
        case .dismiss:
            timer?.restartTimer()
        }
    }

    func updateZoomFactor(factor: CGFloat) {
        zoomFactor = factor
    }

    func toggleFlash() {
        switch captureSession.getFlashMode() {
        case .on:
            flashType = .off
            captureSession.setFlashMode(mode: .off)
        case .off:
            flashType = .on
            captureSession.setFlashMode(mode: .on)
        default:
            return
        }
    }

    func configurePreview(view: AVCapturePreviewView) {
        captureSession.configurePreview(view: view)
    }

    func updateOrientation(orientation: AVCaptureVideoOrientation) {
        captureSession.updateOrientation(orientation: orientation)
    }

    func switchCamera() {
        captureSession.switchCamera()
    }

    func focus(touchLocation: CGPoint) {
        captureSession.focus(touchLocation: touchLocation)
    }

    func minMaxZoom(_ factor: CGFloat) -> CGFloat {
        captureSession.minMaxZoom(factor)
    }

    func updateZoomScaleFactor(scale factor: CGFloat) {
        captureSession.updateZoomScaleFactor(scale: factor)
    }

    private func getPhotoShootData() -> PhotoShootData {
        guard let sessionID = photoShootConfiguration?.sessionID else { fatalError() }
        return PhotoShootData.init(sessionID: sessionID, images: capturedImages)
    }

    private func capturePhoto() {
        onCountdownComplete?()
        captureSession.captureImage()
    }

    private func processImage(image: UIImage) {
        capturedImages.append(image)
        if capturedImages.count == numberOfPhotos {
            timer?.stopTimer()
            onShootComplete?(getPhotoShootData())
        } else {
            timer?.restartTimer()
        }
    }

    private func postCancellationEvent(action: CancellationAction) {
        let configurationParameters = photoShootConfiguration?.parameters ?? [:]
        let parameters = ["action" : action.description,
                          "current_photo_count" : capturedImages.count] + configurationParameters

        Analytics.logEvent("cancellation_action_selected",
                           parameters: parameters)
    }

    private func postImageCapturedEvent(processedImage: ProcessedImage) {
        let configurationParameters = photoShootConfiguration?.parameters ?? [:]
        let parameters = processedImage.parameters + configurationParameters
        Analytics.logEvent("image_captured", parameters: parameters)
    }
}

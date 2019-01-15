import Foundation
import UIKit
import AVFoundation

protocol CameraViewControllerViewModeling {
    var captureSession: PhotoCaptureable { get }
    var timer: TimerModeling? { get }
    var numberOfPhotos: Int { get }
    var capturedImages: [UIImage] { get }
    var cancelEnabled: Bool { get }
    var photoShootConfiguration: PhotoShootConfiguration? { get }
    var onStartNewShoot: () -> Void { get }
    var onCountdownComplete: (() -> Void)? { get set }

    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void)
    func startShoot(onComplete: @escaping ((PhotoShootData) -> Void))
    func reset()
    func processCancellationAction(action: CancellationAction)
    func checkCameraAccess() -> Bool
}

class CameraViewControllerViewModel: CameraViewControllerViewModeling {
    private(set) var captureSession: PhotoCaptureable
    private(set) var timer: TimerModeling?
    private(set) var numberOfPhotos: Int = 0
    private(set) var capturedImages = [UIImage]()
    private(set) var cancelEnabled: Bool = false
    private var onShootComplete: ((PhotoShootData) -> Void)?
    private(set) var photoShootConfiguration: PhotoShootConfiguration?
    let onStartNewShoot: () -> Void
    var onCountdownComplete: (() -> Void)?

    init(captureSession: PhotoCaptureable = PhotoCaptureableFactory.getPhotoCapturable(),
         onStartNewShoot: @escaping () -> Void) {
        self.captureSession = captureSession
        self.onStartNewShoot = onStartNewShoot
        self.captureSession.onImageCaptured = { [weak self] processedImage in
            self?.postImageCapturedEvent(processedImage: processedImage)
            self?.processImage(image: processedImage.image)
        }
    }

    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void) {
        Analytics.logEvent("setup_complete", parameters: ["photo_count" : config.photoCount, "time_interval" : config.timeInterval])
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

    func checkCameraAccess() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            return false
        case .restricted:
            print("Restricted, device owner must approve")
            return false
        case .authorized:
            print("Authorized, proceed")
            return true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
            return false
        }
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

import Foundation
import UIKit

protocol CameraViewControllerViewModeling {
    var captureSession: PhotoCaptureable { get }
    var timer: TimerModeling? { get }
    var numberOfPhotos: Int { get }
    var capturedImages: [UIImage] { get }
    var cancelEnabled: Bool { get }
    var onStartNewShoot: () -> Void { get }
    var onCountdownComplete: (() -> Void)? { get set }

    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void)
    func startShoot(onComplete: @escaping (([UIImage]) -> Void))
    func reset()
    func processCancellationAction(action: CancellationAction)
}

class CameraViewControllerViewModel: CameraViewControllerViewModeling {
    private(set) var captureSession: PhotoCaptureable
    private(set) var timer: TimerModeling?
    private(set) var numberOfPhotos: Int = 0
    private(set) var capturedImages = [UIImage]()
    private(set) var cancelEnabled: Bool = false
    private var onShootComplete: (([UIImage]) -> Void)?
    let onStartNewShoot: () -> Void
    var onCountdownComplete: (() -> Void)?

    init(captureSession: PhotoCaptureable = PhotoCaptureableFactory.getPhotoCapturable(),
         onStartNewShoot: @escaping () -> Void) {
        self.captureSession = captureSession
        self.onStartNewShoot = onStartNewShoot
        self.captureSession.onImageCaptured = { [weak self] image in
            self?.processImage(image: image)
        }
    }

    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void) {
        numberOfPhotos = config.photoCount
        timer = CountdownTimer(seconds: config.timeInterval,
                               onTimerUpdate: { [weak self] timeRemaining in
                                if timeRemaining == 0 {
                                    self?.capturePhoto()
                                }
                                onTimerUpdated(timeRemaining)
        })
    }

    func startShoot(onComplete: @escaping (([UIImage]) -> Void)) {
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
        switch action {
        case .review:
            onShootComplete?(capturedImages)
        case .discard:
            reset()
            onStartNewShoot()
        case .dismiss:
            timer?.restartTimer()
        }
    }

    private func capturePhoto() {
        onCountdownComplete?()
        captureSession.captureImage()
    }

    private func processImage(image: UIImage) {
        capturedImages.append(image)
        if capturedImages.count == numberOfPhotos {
            timer?.stopTimer()
            onShootComplete?(capturedImages)
        } else {
            timer?.restartTimer()
        }
    }
}

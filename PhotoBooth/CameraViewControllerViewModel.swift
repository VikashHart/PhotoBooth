import Foundation
import UIKit

protocol CameraViewControllerViewModeling {
    var captureSession: PhotoCaptureable { get }
    var timer: TimerModeling? { get }
    var numberOfPhotos: Int { get }

    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void)
    func startShoot()
}

class CameraViewControllerViewModel: CameraViewControllerViewModeling {
    private(set) var captureSession: PhotoCaptureable
    private(set) var timer: TimerModeling?
    private(set) var numberOfPhotos: Int = 0
    private(set) var capturedImages = [UIImage]()

    init(captureSession: PhotoCaptureable = PhotoCaptureableFactory.getPhotoCapturable() ) {
        self.captureSession = captureSession
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

    func startShoot() {
        timer?.startTimer()
    }

    private func capturePhoto() {
        captureSession.captureImage()
    }

    private func processImage(image: UIImage) {
        capturedImages.append(image)
        if capturedImages.count == numberOfPhotos {
            timer?.stopTimer()
        } else {
            timer?.restartTimer()
        }
    }
}

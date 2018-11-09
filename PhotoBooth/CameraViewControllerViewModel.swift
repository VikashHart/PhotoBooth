import Foundation

protocol CameraViewControllerViewModeling {
    var timer: TimerModeling? { get }
    var numberOfPhotos: Int { get }
    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void)
    func startShoot()
}

class CameraViewControllerViewModel: CameraViewControllerViewModeling {
    private(set) var timer: TimerModeling?
    private(set) var numberOfPhotos: Int = 0

    func setupShoot(with config: PhotoShootConfiguration,
                    onTimerUpdated: @escaping (Seconds) -> Void) {
        numberOfPhotos = config.photoCount
        timer = CountdownTimer(seconds: config.timeInterval,
                               onTimerUpdate: onTimerUpdated)
    }

    func startShoot() {
        timer?.startTimer()
    }
}

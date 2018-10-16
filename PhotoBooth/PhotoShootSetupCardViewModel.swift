import Foundation

protocol SetupPhotoShootViewModel {
    var photoStepperViewModel: StepperViewModel { get }
    var timerStepperViewModel: StepperViewModel { get }

    func getPhotoShootConfiguration() -> PhotoShootConfiguration
}

struct PhotoShootConfiguration {
    let photoCount: Int
    let timeInterval: TimeInterval
}

class PhotoShootSetupCardViewModel: SetupPhotoShootViewModel {
    private let _photoStepperViewModel = PhotoStepperViewModel(initialValue: 3)
    private let _timerStepperViewModel = TimeIntervalStepperViewModel(initialValue: 5)

    var photoStepperViewModel: StepperViewModel { return _photoStepperViewModel }
    var timerStepperViewModel: StepperViewModel { return _timerStepperViewModel }

    func getPhotoShootConfiguration() -> PhotoShootConfiguration {
        let configuration = PhotoShootConfiguration.init(photoCount: _photoStepperViewModel.currentValue, timeInterval: _timerStepperViewModel.currentValue)
        return configuration
    }
}

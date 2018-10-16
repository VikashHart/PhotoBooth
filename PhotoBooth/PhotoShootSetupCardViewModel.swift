import Foundation

class PhotoShootSetupCardViewModel: SetupPhotoShootViewModel {
    private let _photoStepperViewModel = PhotoStepperViewModel(initialValue: 3)
    private let _timerStepperViewModel = TimeIntervalStepperViewModel(initialValue: 5)

    var photoStepperViewModel: StepperViewModel { return _photoStepperViewModel }
    var timerStepperViewModel: StepperViewModel { return _timerStepperViewModel }

    func getPhotoShootConfiguration() -> PhotoShootConfiguration {
        return PhotoShootConfiguration(photoCount: _photoStepperViewModel.currentValue, timeInterval: _timerStepperViewModel.currentValue)
    }
}

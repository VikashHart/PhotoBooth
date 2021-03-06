import Foundation

class SetupCardViewModel: SetupCardViewModeling {
    let titleText = StyleGuide.AppCopy.CameraVC.setupCardHeaderTitle

    private let _photoStepperViewModel: PhotoStepperViewModel
    private let _timerStepperViewModel: TimeIntervalStepperViewModel

    var photoStepperViewModel: StepperViewModeling { return _photoStepperViewModel }
    var timerStepperViewModel: StepperViewModeling { return _timerStepperViewModel }

    private let onConfigure: ((PhotoShootConfiguration) -> ())

    init(onConfigure: @escaping (PhotoShootConfiguration) -> Void,
         photoStepperViewModel: PhotoStepperViewModel = PhotoStepperViewModel(initialValue: 3),
         timerStepperViewModel: TimeIntervalStepperViewModel = TimeIntervalStepperViewModel(initialValue: 5)) {
        self.onConfigure = onConfigure
        self._photoStepperViewModel = photoStepperViewModel
        self._timerStepperViewModel = timerStepperViewModel
    }

    func finalizeConfiguration() {
        onConfigure(getPhotoShootConfiguration())
    }

    private func getPhotoShootConfiguration() -> PhotoShootConfiguration {
        return PhotoShootConfiguration(photoCount: _photoStepperViewModel.currentValue, timeInterval: _timerStepperViewModel.currentValue)
    }
}

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
    var photoStepperViewModel: StepperViewModel = PhotoStepperViewModel(currentValue: 3, minusEnabled: true, plusEnabled: true, labelText: "3 photos selected")

    var timerStepperViewModel: StepperViewModel = TimeIntervalStepperViewModel(currentValue: 5, minusEnabled: true, plusEnabled: true, labelText: "5 second delay")

    func getPhotoShootConfiguration() -> PhotoShootConfiguration {
        
    }
}

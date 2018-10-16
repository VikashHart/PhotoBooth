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

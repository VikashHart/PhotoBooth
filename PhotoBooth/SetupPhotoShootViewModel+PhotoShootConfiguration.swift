import Foundation

protocol SetupPhotoShootViewModel {
    var titleText: String { get }
    var photoStepperViewModel: StepperViewModel { get }
    var timerStepperViewModel: StepperViewModel { get }

    func finalizeConfiguration()
}

struct PhotoShootConfiguration {
    let photoCount: Int
    let timeInterval: TimeInterval
}

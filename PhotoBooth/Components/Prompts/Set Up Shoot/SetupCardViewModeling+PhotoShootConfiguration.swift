import UIKit

protocol SetupCardViewModeling {
    var titleText: String { get }
    var photoStepperViewModel: StepperViewModeling { get }
    var timerStepperViewModel: StepperViewModeling { get }

    func finalizeConfiguration()
}

struct PhotoShootConfiguration {
    let sessionID = UUID().uuidString
    let photoCount: Int
    let timeInterval: Seconds
}

struct PhotoShootData {
    let sessionID: String
    let images: [UIImage]
}

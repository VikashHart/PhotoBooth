import Foundation

class TimeIntervalStepperViewModel: StepperViewModel {

    var currentValue: TimeInterval

    var minusEnabled: Bool

    var plusEnabled: Bool

    var labelText: String

    init(currentValue: TimeInterval, minusEnabled: Bool, plusEnabled: Bool, labelText: String) {
        self.currentValue = currentValue
        self.minusEnabled = minusEnabled
        self.plusEnabled = plusEnabled
        self.labelText = labelText
    }

    func minusTapped() {
        <#code#>
    }

    func plusTapped() {
        <#code#>
    }


}

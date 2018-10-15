import Foundation

class PhotoStepperViewModel: StepperViewModel {

    var currentValue: Int

    var minusEnabled: Bool

    var plusEnabled: Bool

    var labelText: String

    init(currentValue: Int, minusEnabled: Bool, plusEnabled: Bool, labelText: String) {
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

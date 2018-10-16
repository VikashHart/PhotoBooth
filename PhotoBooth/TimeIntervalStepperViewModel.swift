import Foundation

class TimeIntervalStepperViewModel: StepperViewModel {

    var currentValue: TimeInterval

    var minValue: Double = 1

    var maxValue: Double = 10

    var minusEnabled: Bool = true

    var plusEnabled: Bool = true

    var labelText: String = ""

    init(initialValue: TimeInterval = 0) {
        self.currentValue = initialValue
        updateValues()
    }

    func minusTapped() {

        guard currentValue != minValue else { return }
        currentValue -= 1
    }

    func plusTapped() {

        guard currentValue != maxValue else { return }
        currentValue += 1
    }

    private func updateValues() {
        switch currentValue {
            case 1:
                minusEnabled = false
                plusEnabled = true
            case 2...9:
                minusEnabled = true
                plusEnabled = true
            case 10:
                minusEnabled = true
                plusEnabled = false
            default:
                break
        }
        labelText = textForLabel()
    }

    private func textForLabel() -> String {

        var currentValueAsInt = Int(currentValue)
        var newText = ""
        switch currentValueAsInt {
            case 1:
                newText = "\(currentValueAsInt) second appart"
            case 2...10:
                newText = "\(currentValueAsInt) seconds appart"
            default:
                break
        }
        return newText
    }
}

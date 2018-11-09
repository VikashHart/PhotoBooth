import Foundation

class TimeIntervalStepperViewModel: StepperViewModel {

    private(set) var currentValue: Seconds {
        didSet {
            updateValues()
        }
    }

    private let minValue: Seconds

    private let maxValue: Seconds

    private(set) var minusEnabled: Bool = true

    private(set) var plusEnabled: Bool = true

    private(set) var labelText: String = ""

    init(initialValue: Seconds = 0, min: Seconds = 1, max: Seconds = 10) {
        assert(min <= max)
        self.currentValue = initialValue
        self.minValue = min
        self.maxValue = max
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
                newText = "\(currentValueAsInt) second apart"
            case 2...10:
                newText = "\(currentValueAsInt) seconds apart"
            default:
                break
        }
        return newText
    }
}

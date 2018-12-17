import Foundation

class PhotoStepperViewModel: StepperViewModeling {

    private(set) var currentValue: Int {
        didSet {
            updateValues()
        }
    }

    private let minValue: Int

    private let maxValue: Int

    private(set) var minusEnabled: Bool = true

    private(set) var plusEnabled: Bool = true

    private(set) var labelText: String = ""

    init(initialValue: Int = 0, min: Int = 1, max: Int = 10) {
        assert(min <= max)
        self.minValue = min
        self.maxValue = max
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
        var newText = ""
        switch currentValue {
            case 1 :
                newText = "\(currentValue) photo"
            case 2...10:
                newText = "\(currentValue) photos"
            default:
                break
        }
        return newText
    }
}

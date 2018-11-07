import Foundation

class CountdownIndicatorViewModel: CountdownIndicatorViewModeling {

    private(set) var timerLabelText = ""

    var timeRemaining: Seconds {
        didSet {
            updateText()
        }
    }

    init(time: Seconds = 0) {
        self.timeRemaining = time
        updateText()
    }

    func update(timeRemaining: Seconds) {
        self.timeRemaining = timeRemaining
    }

    private func updateText() {
        timerLabelText = getTimerLabelText()
    }

    private func getTimerLabelText() -> String {
        let time = Int(timeRemaining)
        return String(time)
    }
}

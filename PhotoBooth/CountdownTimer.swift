import Foundation

class CountdownTimer: TimerModeling {
    var timeRemaining: Seconds = 1 {
        didSet {
            if timeRemaining <= 0 {
                removeTimer()
            }
        }
    }

    private var maxTime: Seconds = 1

    private var timer = Timer()

    private var isTimerRunning = false

    private let onTimerUpdated: (Seconds) -> Void

    init(seconds: Seconds, onTimerUpdate: @escaping (Seconds) -> Void) {
        self.onTimerUpdated = onTimerUpdate
        self.timeRemaining = seconds
        self.maxTime = seconds
    }

    func startTimer() {
        guard !isTimerRunning else { return }
        isTimerRunning = true
        onTimerUpdated(timeRemaining)
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: (#selector(updateTimer)),
                                     userInfo: nil,
                                     repeats: true)
    }

    func pauseTimer() {
        removeTimer()
    }

    func restartTimer() {
        removeTimer()
        timeRemaining = maxTime
        startTimer()
    }

    private func removeTimer() {
        timer.invalidate()
        isTimerRunning = false
    }

    @objc private func updateTimer() {
        guard isTimerRunning else { return }
        timeRemaining -= 1
        onTimerUpdated(timeRemaining)
    }
}

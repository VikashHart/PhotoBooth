import Foundation

protocol CountdownIndicatorViewModeling {
    var timerLabelText: String { get }
    func update(timeRemaining: Seconds)
}

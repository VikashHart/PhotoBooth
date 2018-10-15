import Foundation

protocol StepperViewModel {
    var minusEnabled: Bool { get }
    var plusEnabled: Bool  { get }
    var labelText: String  { get }

    func minusTapped()
    func plusTapped()
}

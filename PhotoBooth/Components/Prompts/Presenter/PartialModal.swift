import UIKit

protocol PartialModal {
    var view: UIView { get }
    var delegate: PartialModalDelegate? { get set }
    func dismiss()
}

protocol PartialModalDelegate {
    func dismissRequested(modal: PartialModal)
}

func ==(lhs: PartialModal, rhs: PartialModal) -> Bool {
    return lhs.view == rhs.view
}

extension PartialModal {
    func dismiss() {
        delegate?.dismissRequested(modal: self)
    }
}

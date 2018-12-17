import UIKit

class PromptView: UIView, PartialModalDelegate {
    private(set) var currentModal: PartialModal?

    func present(modal: PartialModal, animated: Bool) {
        currentModal?.dismiss()

        superview?.bringSubview(toFront: self)
        let modalView = modal.view
        modalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(modalView)
        NSLayoutConstraint.activate([
            modalView.topAnchor.constraint(equalTo: topAnchor),
            modalView.bottomAnchor.constraint(equalTo: bottomAnchor),
            modalView.leadingAnchor.constraint(equalTo: leadingAnchor),
            modalView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])

        if animated {
            layoutIfNeeded()
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        } else {
            layoutIfNeeded()
            alpha = 1
        }

        currentModal = modal
        currentModal?.delegate = self
    }

    func dismissRequested(modal: PartialModal) {
        if let current = currentModal, current == modal {
            alpha = 0
            current.view.removeFromSuperview()
            currentModal?.delegate = nil
            currentModal = nil
        }
    }
}

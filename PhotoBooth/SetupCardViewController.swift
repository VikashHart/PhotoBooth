import UIKit

class SetupCardViewController: UIViewController {

    let setupCard = PhotoShootSetupCard()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSetupCard()
        view.backgroundColor = .clear
    }

    private func configureSetupCard() {
        view.addSubview(setupCard)
        setupCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setupCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            setupCard.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor),
            setupCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setupCard.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

class PromptView: UIView, PartialModalDelegate {
    private(set) var currentModal: PartialModal?

    func present(modal: PartialModal, animated: Bool) {
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
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
                self.layoutIfNeeded()
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

protocol PartialModal {
    var view: UIView { get }
    var delegate: PartialModalDelegate? { get set }
}

protocol PartialModalDelegate {
    func dismissRequested(modal: PartialModal)
}

func ==(lhs: PartialModal, rhs: PartialModal) -> Bool {
    return lhs.view == rhs.view
}

class SetUpCardPartialModal: PartialModal {
    var view: UIView = PhotoShootSetupCard()
    var delegate: PartialModalDelegate?
}

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

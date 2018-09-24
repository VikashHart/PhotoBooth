import UIKit

class SetupCardViewController: UIViewController {

    let setupCard = PhotoShootSetupCard()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSetupCard()

    }

    private func configureSetupCard() {
        view.addSubview(setupCard)
        setupCard.translatesAutoresizingMaskIntoConstraints = false
    }
}

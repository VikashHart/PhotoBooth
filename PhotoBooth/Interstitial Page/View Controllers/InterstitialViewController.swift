import UIKit

class InterstitialViewController: UIViewController {

    private let interstitialView = InterstitialView()
    private let viewModel: InterstitialVCViewModeling = InterstitialVCViewModel()
    private var updateView: UpdateView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindRemoteConfig()
        bindLoadComplete()
        bindLoadFail()
    }

    private func bindRemoteConfig() {
        if RemoteConfigStore.configStore.loadComplete {
            executeUpdateRoutine()
        }
    }

    private func bindLoadComplete() {
        RemoteConfigStore.configStore.loadingDidComplete = { [weak self] in
            self?.executeUpdateRoutine()
        }
    }

    private func bindLoadFail() {
        RemoteConfigStore.configStore.loadingDidFail = { [weak self] in
            self?.presentCameraVC()
        }
    }

    private func executeUpdateRoutine() {
        interstitialView.endLoad()
        guard let payload = RemoteConfigStore.configStore.configPayload.first else { return }

        if viewModel.showUpdate() {
            let configuration = viewModel.getUpdateConfiguraion()
            switch configuration {
            case .laterAndUpdate:
                let text = StyleGuide.AppCopy.InterstitialVC.none
                buildUpdateView(with: payload,
                                configuration: .laterAndUpdate,
                                requirementText: text)
                configureUpdateView()
                guard let updateCard = updateView else { return presentCameraVC() }
                view.bringSubviewToFront(updateCard)
            case .okay:
                let text = "Requires iOS \(payload.minSupportediOSVersion) or higher."
                buildUpdateView(with: payload,
                                configuration: .okay,
                                requirementText: text)
                configureUpdateView()
                guard let updateCard = updateView else { return presentCameraVC() }
                view.bringSubviewToFront(updateCard)
            case .update:
                let text = StyleGuide.AppCopy.InterstitialVC.versionUnsuported
                buildUpdateView(with: payload,
                                configuration: .update,
                                requirementText: text)
                configureUpdateView()
                guard let updateCard = updateView else { return presentCameraVC() }
                view.bringSubviewToFront(updateCard)
            case .none:
                let text = "Your version of Lens is no longer supported & requires iOS \(payload.minSupportediOSVersion) or higher."
                buildUpdateView(with: payload,
                                configuration: .none,
                                requirementText: text)
                configureUpdateView()
                guard let updateCard = updateView else { return presentCameraVC() }
                view.bringSubviewToFront(updateCard)
            }
        } else {
            presentCameraVC()
        }
    }

    private func presentCameraVC() {
        let cameraVC = CameraViewController()
        cameraVC.modalPresentationStyle = .fullScreen
        present(cameraVC, animated: true, completion: nil)
    }

    private func buildUpdateView(with payload: RCPayload,
                                    configuration: UpdateConfiguration,
                                    requirementText: String) {
        let viewModel: UpdateViewModeling = UpdateViewModel(payload: payload, requirements: requirementText)
        let updateView = UpdateView(viewModel: viewModel, configuration: configuration)
        self.updateView = updateView
    }

    private func configureView() {
        setupConstraints()
        interstitialView.startLoad()
    }

    private func configureUpdateView() {
        constrainUpdateView()
        setupButtons()
    }

    private func setupConstraints() {
        view.addSubview(interstitialView)
        interstitialView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            interstitialView.topAnchor.constraint(equalTo: view.topAnchor),
            interstitialView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            interstitialView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            interstitialView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func constrainUpdateView() {
        guard let updateView = updateView else { return presentCameraVC() }
        view.addSubview(updateView)
        updateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            updateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            updateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            updateView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.8)
        ])
    }

    private func setupButtons() {
        guard let updateView = updateView else { return }
        updateView.laterButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        updateView.okayButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        updateView.updateButton.addTarget(self, action: #selector(presentAppStorePage), for: .touchUpInside)
    }

    @objc private func dismissView() {
        presentCameraVC()
    }

    @objc private func presentAppStorePage() {
        let urlString = "itms-apps://apps.apple.com/app/id1447331697"

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: urlString)!)
        }
    }
}

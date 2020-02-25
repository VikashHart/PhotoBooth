import UIKit

class PreviewViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    private let viewModel: PreviewViewControllerModel

    lazy var previewView: PreviewView = {
        let view = PreviewView(viewModel: viewModel.previewViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreviewView()
        previewView.backButton.addTarget(self,
                                           action: #selector(backSelected),
                                           for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(image: UIImage) {
        self.viewModel = PreviewViewControllerModel(image: image)
        super.init(nibName: nil, bundle: nil)
    }

    @objc private func backSelected() {
        coordinator?.dismiss()
    }

    private func setupPreviewView() {
        view.addSubview(previewView)
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: view.topAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

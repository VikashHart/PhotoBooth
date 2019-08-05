import UIKit
import Motion

class PreviewViewController: UIViewController {

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
        self.isMotionEnabled = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(image: UIImage, imageIdentifier: String) {
        self.viewModel = PreviewViewControllerModel(image: image,
                                                    imageIdentifier: imageIdentifier)
        super.init(nibName: nil, bundle: nil)
    }

    @objc private func backSelected() {
        dismiss(animated: true, completion: nil)
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

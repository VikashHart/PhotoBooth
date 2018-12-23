import UIKit

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.all)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.portrait)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(image: UIImage) {
        self.viewModel = PreviewViewControllerModel(image: image)
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

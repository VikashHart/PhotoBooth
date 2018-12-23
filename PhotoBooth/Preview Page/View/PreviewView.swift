import UIKit

class PreviewView: UIView {

    let viewModel: PreviewViewModel

    lazy var previewImageView: UIImageView = {
        let photo = UIImageView()
        photo.image = viewModel.image
        photo.tintColor = .white
        photo.contentMode = .scaleAspectFit
        photo.backgroundColor = .black
        photo.layer.masksToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 18)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: PreviewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
    }

    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        setupPreviewImageView()
        setupBackButton()
    }

    private func setupPreviewImageView() {
        addSubview(previewImageView)
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupBackButton() {
        addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15)
            ])
    }
}

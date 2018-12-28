import UIKit

class PreviewView: UIView {

    let viewModel: PreviewViewModel

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = viewModel.image
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
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

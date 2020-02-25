import UIKit

class BackdropSelector: UIView {

    lazy var backdropContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var backdropImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "test")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var backdropLabel: UILabel = {
        let label = UILabel()
        label.text = "NewLabel"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var backdropButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        setupContainer()
        setupImageView()
        setupLabel()
        setupButton()
    }

    private func setupContainer() {
        addSubview(backdropContainer)
        NSLayoutConstraint.activate([
            backdropContainer.topAnchor.constraint(equalTo: topAnchor),
            backdropContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            backdropContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            backdropContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupImageView() {
        backdropContainer.addSubview(backdropImageView)
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: backdropContainer.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: backdropContainer.leadingAnchor),
            backdropImageView.bottomAnchor.constraint(equalTo: backdropContainer.bottomAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 40),
            backdropImageView.widthAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupLabel() {
        backdropContainer.addSubview(backdropLabel)
        NSLayoutConstraint.activate([
            backdropLabel.topAnchor.constraint(equalTo: backdropContainer.topAnchor),
            backdropLabel.leadingAnchor.constraint(equalTo: backdropImageView.trailingAnchor),
            backdropLabel.trailingAnchor.constraint(equalTo: backdropContainer.trailingAnchor),
            backdropLabel.bottomAnchor.constraint(equalTo: backdropContainer.bottomAnchor)
            ])
    }

    private func setupButton() {
        backdropContainer.addSubview(backdropButton)
        NSLayoutConstraint.activate([
            backdropButton.topAnchor.constraint(equalTo: backdropContainer.topAnchor),
            backdropButton.leadingAnchor.constraint(equalTo: backdropContainer.leadingAnchor),
            backdropButton.trailingAnchor.constraint(equalTo: backdropContainer.trailingAnchor),
            backdropButton.bottomAnchor.constraint(equalTo: backdropContainer.bottomAnchor)
            ])
    }

}


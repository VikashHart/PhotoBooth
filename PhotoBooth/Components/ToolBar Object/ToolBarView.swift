import UIKit

class ToolbarView: UIView {

    weak var delegate: ToolbarDelegate?

    //MARK: - Objects
    lazy var blurContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addBlurEffect(blurStyle: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shareContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var saveContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = true
        button.addTarget(self,
                         action: #selector(shareTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = true
        button.addTarget(self,
                         action: #selector(saveTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var shareIcon: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: StyleGuide.Assets.shareIcon)?.withRenderingMode(.alwaysTemplate)
        view.image = image
        view.tintColor = .white
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var saveIcon: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: StyleGuide.Assets.saveIcon)?.withRenderingMode(.alwaysTemplate)
        view.image = image
        view.tintColor = .white
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shareTitle: UILabel = {
        let label = UILabel()
        label.text = StyleGuide.AppCopy.Toolbar.shareText
        label.textColor = .white
        label.font = UIFont.regularFont(size: 15)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var saveTitle: UILabel = {
        let label = UILabel()
        label.text = StyleGuide.AppCopy.Toolbar.saveText
        label.textColor = .white
        label.font = UIFont.regularFont(size: 15)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    //MARK: - Setup Methods
    private func commonInit() {
        configureView()
        setupViews()
    }

    private func configureView() {
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
    }

    private func setupViews() {
        setupBlurView()
        setupStackView()
        setupShareContainer()
        setupShareIcon()
        setupShareTitle()
        setupShareButton()
        setupSaveContainer()
        setupSaveIcon()
        setupSaveTitle()
        setupSaveButton()
    }

    //MARK: - Constraints
    private func setupBlurView() {
        addSubview(blurContainer)
        NSLayoutConstraint.activate([
            blurContainer.topAnchor.constraint(equalTo: topAnchor),
            blurContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupStackView() {
        blurContainer.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: blurContainer.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: blurContainer.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: blurContainer.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: blurContainer.bottomAnchor)
        ])
    }

    private func setupShareContainer() {
        stackView.addArrangedSubview(shareContainer)
    }

    private func setupShareIcon() {
        shareContainer.addSubview(shareIcon)
        NSLayoutConstraint.activate([
            shareIcon.topAnchor.constraint(equalTo: shareContainer.topAnchor, constant: 4),
            shareIcon.leadingAnchor.constraint(equalTo: shareContainer.leadingAnchor),
            shareIcon.trailingAnchor.constraint(equalTo: shareContainer.trailingAnchor)
        ])
    }

    private func setupShareTitle() {
        shareContainer.addSubview(shareTitle)
        NSLayoutConstraint.activate([
            shareTitle.topAnchor.constraint(equalTo: shareIcon.bottomAnchor),
            shareTitle.leadingAnchor.constraint(equalTo: shareContainer.leadingAnchor),
            shareTitle.trailingAnchor.constraint(equalTo: shareContainer.trailingAnchor),
            shareTitle.heightAnchor.constraint(equalToConstant: 20),
            shareTitle.bottomAnchor.constraint(equalTo: shareContainer.bottomAnchor, constant: -4)
        ])
    }

    private func setupShareButton() {
        shareContainer.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: shareContainer.topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: shareContainer.leadingAnchor),
            shareButton.trailingAnchor.constraint(equalTo: shareContainer.trailingAnchor),
            shareButton.bottomAnchor.constraint(equalTo: shareContainer.bottomAnchor)
        ])
    }

    private func setupSaveContainer() {
        stackView.addArrangedSubview(saveContainer)
    }

    private func setupSaveIcon() {
        saveContainer.addSubview(saveIcon)
        NSLayoutConstraint.activate([
            saveIcon.topAnchor.constraint(equalTo: saveContainer.topAnchor, constant: 4),
            saveIcon.leadingAnchor.constraint(equalTo: saveContainer.leadingAnchor),
            saveIcon.trailingAnchor.constraint(equalTo: saveContainer.trailingAnchor)
        ])
    }

    private func setupSaveTitle() {
        saveContainer.addSubview(saveTitle)
        NSLayoutConstraint.activate([
            saveTitle.topAnchor.constraint(equalTo: saveIcon.bottomAnchor),
            saveTitle.leadingAnchor.constraint(equalTo: saveContainer.leadingAnchor),
            saveTitle.trailingAnchor.constraint(equalTo: saveContainer.trailingAnchor),
            saveTitle.heightAnchor.constraint(equalToConstant: 20),
            saveTitle.bottomAnchor.constraint(equalTo: saveContainer.bottomAnchor, constant: -4)
        ])
    }

    private func setupSaveButton() {
        saveContainer.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: saveContainer.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: saveContainer.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: saveContainer.trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: saveContainer.bottomAnchor)
        ])
    }

    //MARK: - Functions
    @objc private func shareTapped() {
        delegate?.shareTapped()
    }

    @objc private func saveTapped() {
        delegate?.saveTapped()
    }

    func deactivateButtons() {
        saveButton.isEnabled = false
        shareButton.isEnabled = false
    }

    func activateButtons() {
        saveButton.isEnabled = true
        shareButton.isEnabled = true
    }
}

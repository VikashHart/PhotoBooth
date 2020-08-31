import UIKit

class UpdateView: UIView {
    private var viewModel: UpdateViewModeling

    // MARK: - Objects
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.shadowGray.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var bannerImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: StyleGuide.Assets.updateBanner)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var appLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: StyleGuide.Assets.appLogo)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.semiBoldFont(size: 22)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumFont(size: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumFont(size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var requirementsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.romanFont(size: 12)
        label.textColor = .red
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var laterButton: UIButton = {
        let button = UIButton()
        button.setTitle(StyleGuide.AppCopy.InterstitialVC.laterButtonText, for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle(StyleGuide.AppCopy.InterstitialVC.updateButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .photoBoothBlue
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var okayButton: UIButton = {
        let button = UIButton()
        button.setTitle(StyleGuide.AppCopy.InterstitialVC.okayButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .photoBoothBlue
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: UpdateViewModeling,
         configuration: UpdateConfiguration) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
        addButtons(configuration: configuration)
        configureUI()
    }

    // MARK: - Setup Methods
    private func commonInit() {
        setupViews()
    }

    private func setupViews() {
        setupContainerView()
        setupBannerView()
        setupAppLogo()
        setupTitleLabel()
        setupLineView()
        setupSubtitleLabel()
        setupBodyLabel()
        setupRequirementsLabel()
    }

    // MARK: - Constraints
    private func setupContainerView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupBannerView() {
        containerView.addSubview(bannerImageView)
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 19),
            bannerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 32),
            bannerImageView.widthAnchor.constraint(equalToConstant: 95)
        ])
    }

    private func setupAppLogo() {
        containerView.addSubview(appLogo)
        NSLayoutConstraint.activate([
            appLogo.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 19),
            appLogo.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            appLogo.heightAnchor.constraint(equalToConstant: 32),
            appLogo.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func setupTitleLabel() {
        containerView.addSubview(titleLable)
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16),
            titleLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }

    private func setupLineView() {
        containerView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 12),
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func setupSubtitleLabel() {
        containerView.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }

    private func setupBodyLabel() {
        containerView.addSubview(bodyLabel)
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }

    private func setupRequirementsLabel() {
        containerView.addSubview(requirementsLabel)

        if viewModel.requirementText == "" {
            NSLayoutConstraint.activate([
                bodyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
            ])
        } else {
            NSLayoutConstraint.activate([
                requirementsLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 20),
                requirementsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                requirementsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                requirementsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
            ])
        }
    }

    private func addButtons(configuration: UpdateConfiguration) {
        switch configuration {
        case .laterAndUpdate:
            configureTwoButtons()
        case .okay:
            configureOkay()
        case .update:
            configureUpdate()
        case .none:
            configureNone()
        }
    }

    private func getWidthMultiplier() -> CGFloat {
        return 0.33 * (self.bounds.width - 16)
    }

    private func configureTwoButtons() {
        addSubview(laterButton)
        addSubview(updateButton)

        NSLayoutConstraint.activate([
            updateButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24),
            updateButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            updateButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            updateButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            updateButton.heightAnchor.constraint(equalToConstant: 44),

            laterButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24),
            laterButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            laterButton.trailingAnchor.constraint(equalTo: updateButton.leadingAnchor, constant: -16),
            laterButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            laterButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func configureOkay() {
        addSubview(okayButton)

        NSLayoutConstraint.activate([
            okayButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24),
            okayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            okayButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            okayButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            okayButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func configureUpdate() {
        addSubview(updateButton)

        NSLayoutConstraint.activate([
            updateButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24),
            updateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            updateButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            updateButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            updateButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func configureNone() {
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureUI() {
        titleLable.text = viewModel.titleText
        subtitleLabel.text = viewModel.subtitleText
        bodyLabel.text = viewModel.bodyText
        requirementsLabel.text = viewModel.requirementText
        bodyLabel.lineSpacing(spacingValue: 12)
    }
}

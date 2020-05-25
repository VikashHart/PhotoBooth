import UIKit

class SetupCardView: UIView {

    private let viewModel: SetupCardViewModeling

    lazy var UIContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.addBlurEffect()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 35
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: StyleGuide.Assets.cameraIcon)?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.titleText
        label.font = UIFont.mediumFont(size: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var photoStepper: CustomStepper = {
        let stepper = CustomStepper(viewModel: viewModel.photoStepperViewModel)
        stepper.layer.cornerRadius = 10
        stepper.layer.masksToBounds = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    lazy var timerStepper: CustomStepper = {
        let stepper = CustomStepper(viewModel: viewModel.timerStepperViewModel)
        stepper.layer.cornerRadius = 10
        stepper.layer.masksToBounds = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    lazy var startShootContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var startShootButton: UIButton = {
        let button = UIButton()
        button.setTitle(StyleGuide.AppCopy.CameraVC.startShoot, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.regularFont(size: 22)
        button.contentMode = .center
        button.backgroundColor = UIColor.photoBoothBlue
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(completeConfiguration), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: SetupCardViewModeling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        setupViews()
        animateShimmer()
    }

    private func setupViews() {
        setupUIContainer()
        setupIconContainer()
        setupIconImageView()
        setupHeaderLabel()
        setupPhotoStepper()
        setupTimerStepper()
        setupStartShootContainer()
        setupStartShootButton()
    }

    private func setupUIContainer() {
        addSubview(UIContainer)
        NSLayoutConstraint.activate([
            UIContainer.topAnchor.constraint(equalTo: topAnchor),
            UIContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            UIContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupIconContainer() {
        UIContainer.addSubview(iconContainer)
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: UIContainer.topAnchor, constant: 20),
            iconContainer.centerXAnchor.constraint(equalTo: UIContainer.centerXAnchor),
            iconContainer.heightAnchor.constraint(equalToConstant: 70),
            iconContainer.widthAnchor.constraint(equalToConstant: 70)
        ])
    }

    private func setupIconImageView() {
        iconContainer.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 40),
            iconView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupHeaderLabel() {
        UIContainer.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: UIContainer.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: UIContainer.trailingAnchor, constant: -20),
            headerLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupPhotoStepper() {
        UIContainer.addSubview(photoStepper)
        NSLayoutConstraint.activate([
            photoStepper.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            photoStepper.leadingAnchor.constraint(equalTo: UIContainer.leadingAnchor, constant: 24),
            photoStepper.trailingAnchor.constraint(equalTo: UIContainer.trailingAnchor, constant: -24),
        ])
    }

    private func setupTimerStepper() {
        UIContainer.addSubview(timerStepper)
        NSLayoutConstraint.activate([
            timerStepper.topAnchor.constraint(equalTo: photoStepper.bottomAnchor, constant: 24),
            timerStepper.leadingAnchor.constraint(equalTo: UIContainer.leadingAnchor, constant: 24),
            timerStepper.trailingAnchor.constraint(equalTo: UIContainer.trailingAnchor, constant: -24),
            timerStepper.bottomAnchor.constraint(equalTo: UIContainer.bottomAnchor, constant: -24)
        ])
    }

    private func setupStartShootContainer() {
        addSubview(startShootContainer)
        NSLayoutConstraint.activate([
            startShootContainer.topAnchor.constraint(equalTo: UIContainer.bottomAnchor),
            startShootContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            startShootContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            startShootContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupStartShootButton() {
        startShootContainer.addSubview(startShootButton)
        NSLayoutConstraint.activate([
            startShootButton.topAnchor.constraint(equalTo: startShootContainer.topAnchor, constant: 24),
            startShootButton.leadingAnchor.constraint(equalTo: startShootContainer.leadingAnchor, constant: 24),
            startShootButton.trailingAnchor.constraint(equalTo: startShootContainer.trailingAnchor, constant: -24),
            startShootButton.heightAnchor.constraint(equalToConstant: 40),
            startShootButton.bottomAnchor.constraint(equalTo: startShootContainer.bottomAnchor, constant: -24)
        ])
    }

    private func animateShimmer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            let shimmerMask = UIView(frame: self.startShootButton.bounds)
            shimmerMask.layer.cornerRadius = self.startShootButton.layer.cornerRadius
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .repeat,
                           animations: {
                            self.startShootButton.animateShimmer(
                                withMask: shimmerMask,
                                shimmerWidth: shimmerMask.bounds.height,
                                maskColor: .white,
                                duration: 1,
                                repeatCount: 1,
                                insertionPoint: 0)
            }) { (true) in
                self.animateShimmer()
            }
        }
    }

    @objc private func completeConfiguration(sender: UIButton) {
        viewModel.finalizeConfiguration()
    }
}

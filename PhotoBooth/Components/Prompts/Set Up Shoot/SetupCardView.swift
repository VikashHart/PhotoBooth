import UIKit

class SetupCardView: UIView {

    private let viewModel: SetupCardViewModeling

    lazy var UIContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.addBlurEffect()
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var startShootButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "camera_icon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.backgroundColor = UIColor.photoBoothBlue
        button.layer.opacity = 1
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
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
    }

    private func setupViews() {
        setupUIContainer()
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
            UIContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            UIContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }

    private func setupHeaderLabel() {
        UIContainer.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            headerLabel.leadingAnchor.constraint(equalTo: UIContainer.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: UIContainer.trailingAnchor, constant: -20),
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
            timerStepper.topAnchor.constraint(equalTo: photoStepper.bottomAnchor, constant: 20),
            timerStepper.leadingAnchor.constraint(equalTo: UIContainer.leadingAnchor, constant: 24),
            timerStepper.trailingAnchor.constraint(equalTo: UIContainer.trailingAnchor, constant: -24)
            ])
    }

    private func setupStartShootContainer() {
        addSubview(startShootContainer)
        NSLayoutConstraint.activate([
            startShootContainer.topAnchor.constraint(equalTo: timerStepper.bottomAnchor, constant: 20),
            startShootContainer.centerXAnchor.constraint(equalTo: UIContainer.centerXAnchor),
            startShootContainer.centerYAnchor.constraint(equalTo: UIContainer.bottomAnchor),
            startShootContainer.heightAnchor.constraint(equalToConstant: 60),
            startShootContainer.widthAnchor.constraint(equalToConstant: 60)
            ])
    }

    private func setupStartShootButton() {
        startShootContainer.addSubview(startShootButton)
        NSLayoutConstraint.activate([
            startShootButton.topAnchor.constraint(equalTo: startShootContainer.topAnchor),
            startShootButton.centerXAnchor.constraint(equalTo: startShootContainer.centerXAnchor),
            startShootButton.centerYAnchor.constraint(equalTo: startShootContainer.centerYAnchor),
            startShootButton.heightAnchor.constraint(equalToConstant: 60),
            startShootButton.widthAnchor.constraint(equalToConstant: 60)
            ])
    }

    @objc private func completeConfiguration(sender: UIButton) {
        viewModel.finalizeConfiguration()
    }
}

import UIKit

class CustomStepper: UIView {

    private let viewModel: StepperViewModeling

    lazy var stepperMinusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stepper_minus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        button.tintColor = UIColor.photoBoothBlue
        button.contentMode = .center
        button.backgroundColor = .clear
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(minusButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()

    lazy var stepperLabel: UILabel = {
        let label = UILabel()
        label.text = "# of _ selected"
        label.font = UIFont.regularFont(size: 14)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var stepperPlusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stepper_plus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.tintColor = UIColor.photoBoothBlue
        button.contentMode = .center
        button.backgroundColor = .clear
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(plusButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()

    init(viewModel: StepperViewModeling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
        updateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func commonInit() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        setupConstraints()
    }

    private func setupConstraints() {
        setupMinusButton()
        setupPlusButton()
        setupStepperLabel()
    }

    private func setupMinusButton() {
        addSubview(stepperMinusButton)
        NSLayoutConstraint.activate([
            stepperMinusButton.topAnchor.constraint(equalTo: topAnchor),
            stepperMinusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stepperMinusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            stepperMinusButton.heightAnchor.constraint(equalToConstant: 40),
            stepperMinusButton.widthAnchor.constraint(equalTo: stepperMinusButton.heightAnchor)
            ])
    }

    private func setupPlusButton() {
        addSubview(stepperPlusButton)
        NSLayoutConstraint.activate([
            stepperPlusButton.topAnchor.constraint(equalTo: topAnchor),
            stepperPlusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stepperPlusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            stepperPlusButton.heightAnchor.constraint(equalToConstant: 40),
            stepperPlusButton.widthAnchor.constraint(equalTo: stepperPlusButton.heightAnchor)
            ])
    }

    private func setupStepperLabel() {
        addSubview(stepperLabel)
        NSLayoutConstraint.activate([
            stepperLabel.topAnchor.constraint(equalTo: topAnchor),
            stepperLabel.leadingAnchor.constraint(equalTo: stepperMinusButton.trailingAnchor),
            stepperLabel.trailingAnchor.constraint(equalTo: stepperPlusButton.leadingAnchor),
            stepperLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            stepperLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func updateUI() {
        stepperMinusButton.isEnabled = viewModel.minusEnabled
        stepperPlusButton.isEnabled = viewModel.plusEnabled
        stepperLabel.text = viewModel.labelText
    }

    @objc private func minusButtonTapped(sender: UIButton) {
        viewModel.minusTapped()
        updateUI()
    }

    @objc private func plusButtonTapped(sender: UIButton) {
        viewModel.plusTapped()
        updateUI()
    }
}

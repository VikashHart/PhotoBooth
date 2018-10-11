import UIKit

class CustomStepper: UIView {

    lazy var stepperMinusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stepper_minus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        button.tintColor = UIColor.photoBoothBlue
        button.contentMode = .center
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var stepperLabel: UILabel = {
        let label = UILabel()
        label.text = "# of _ selected"
        label.font = UIFont.regularFont(size: 18)
        label.textAlignment = .center
        label.textColor = .gray
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var stepperPlusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stepper_plus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
        button.tintColor = UIColor.photoBoothBlue
        button.contentMode = .center
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConstraints()
        self.backgroundColor = .white
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
            stepperMinusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            stepperMinusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            stepperMinusButton.heightAnchor.constraint(equalToConstant: 40),
            stepperMinusButton.widthAnchor.constraint(equalTo: stepperMinusButton.heightAnchor)
            ])
    }

    private func setupPlusButton() {
        addSubview(stepperPlusButton)
        NSLayoutConstraint.activate([
            stepperPlusButton.topAnchor.constraint(equalTo: topAnchor),
            stepperPlusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
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
}

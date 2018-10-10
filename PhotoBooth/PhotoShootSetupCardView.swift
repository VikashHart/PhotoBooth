import UIKit

class PhotoShootSetupCard: UIView {

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Setup your photoshoot"
        label.font = UIFont.semiBoldFont(size: 22)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var photosStepperContainerUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var photoStepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.stepperLabel.text = "# of photos selected"
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    lazy var timerStepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.stepperLabel.text = "# of seconds selected"
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    lazy var photoColorBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.photoBoothBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var timerColorBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.photoBoothBlue
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        setupViews()
    }

    private func setupViews() {
        setupHeaderLabel()
        setupPhotoSteper()
        setupPhotosColorBar()
        setupTimerStepper()
        setupTimerColorBar()
        setupStartShootButton()
    }

    private func setupHeaderLabel() {
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            ])
    }

    private func setupPhotoSteper() {
        addSubview(photoStepper)
        NSLayoutConstraint.activate([
            photoStepper.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            photoStepper.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            photoStepper.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            ])
    }

    private func setupPhotosColorBar() {
        addSubview(photoColorBar)
        NSLayoutConstraint.activate([
            photoColorBar.topAnchor.constraint(equalTo: photoStepper.bottomAnchor, constant: 0),
            photoColorBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            photoColorBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            photoColorBar.heightAnchor.constraint(equalToConstant: 2.5),
            ])
    }

    private func setupTimerStepper() {
        addSubview(timerStepper)
        NSLayoutConstraint.activate([
            timerStepper.topAnchor.constraint(equalTo: photoColorBar.bottomAnchor, constant: 30),
            timerStepper.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            timerStepper.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
            ])
    }

    private func setupTimerColorBar() {
        addSubview(timerColorBar)
        NSLayoutConstraint.activate([
            timerColorBar.topAnchor.constraint(equalTo: timerStepper.bottomAnchor, constant: 0),
            timerColorBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            timerColorBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            timerColorBar.heightAnchor.constraint(equalToConstant: 2.5),
            ])
    }

    private func setupStartShootButton() {
        addSubview(startShootButton)
        NSLayoutConstraint.activate([
            startShootButton.topAnchor.constraint(equalTo: timerColorBar.bottomAnchor, constant: 55),
            startShootButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            startShootButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            startShootButton.heightAnchor.constraint(equalToConstant: 40),
            startShootButton.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -30)
            ])
    }
}

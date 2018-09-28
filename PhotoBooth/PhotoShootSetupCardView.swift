import UIKit

class PhotoShootSetupCard: UIView {

    let fontRegular = "AvenirNext-Regular"
    let fontBold = "AvenirNext-Bold"

    let photoBoothBlue = UIColor(red: 38/225, green: 185/225, blue: 224/225, alpha: 1)

    lazy var cardUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.opacity = 0.95
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Setup your photoshoot"
        label.font = UIFont(name: fontBold, size: 22)
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

    lazy var photosStepperMinusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stepper_minus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = photoBoothBlue
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var photosStepperLabel: UILabel = {
        let label = UILabel()
        label.text = "10 Photos Selected"
        label.font = UIFont(name: fontRegular, size: 18)
        label.textAlignment = .center
        label.textColor = .gray
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var photosStepperPlusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stepper_plus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = photoBoothBlue
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var photosColorBarUIView: UIView = {
        let view = UIView()
        view.backgroundColor = photoBoothBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var timerStepperContainerUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var timerStepperMinusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stepper_minus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = photoBoothBlue
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var timerStepperLabel: UILabel = {
        let label = UILabel()
        label.text = "10 Seconds Selected"
        label.font = UIFont(name: fontRegular, size: 18)
        label.textAlignment = .center
        label.textColor = .gray
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var timerStepperPlusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stepper_plus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = photoBoothBlue
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var timerColorBarUIView: UIView = {
        let view = UIView()
        view.backgroundColor = photoBoothBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var startShootButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.backgroundColor = photoBoothBlue
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        setupViews()
    }

    private func setupViews() {
        setupCard()
        setupHeaderLabel()
        setupPhotosStepperContainer()
        setupPhotosPlusButton()
        setupPhotosMinusButton()
        setupPhotosStepperLabel()
        setupPhotosColorBar()
        setupSecondsStepperContainer()
        setupTimerMinusButton()
        setupTimerPlusButton()
        setupTimerStepperLabel()
        setupTimerColorBar()
        setupStartShootButton()
    }

    private func setupCard() {
        addSubview(cardUIView)
        NSLayoutConstraint.activate([
            cardUIView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            cardUIView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor),
            cardUIView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardUIView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }

    private func setupHeaderLabel() {
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: cardUIView.topAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -10),
            headerLabel.centerXAnchor.constraint(equalTo: cardUIView.centerXAnchor)
            ])
    }

    private func setupPhotosStepperContainer() {
        addSubview(photosStepperContainerUIView)
        NSLayoutConstraint.activate([
            photosStepperContainerUIView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            photosStepperContainerUIView.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 16),
            photosStepperContainerUIView.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -16),
            photosStepperContainerUIView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupPhotosMinusButton() {
        photosStepperContainerUIView.addSubview(photosStepperMinusButton)
        NSLayoutConstraint.activate([
            photosStepperMinusButton.topAnchor.constraint(equalTo: photosStepperContainerUIView.topAnchor),
            photosStepperMinusButton.leadingAnchor.constraint(equalTo: photosStepperContainerUIView.leadingAnchor),
            photosStepperMinusButton.bottomAnchor.constraint(equalTo: photosStepperContainerUIView.bottomAnchor),
            photosStepperMinusButton.widthAnchor.constraint(equalToConstant: 30)
            ])
    }

    private func setupPhotosPlusButton() {
        photosStepperContainerUIView.addSubview(photosStepperPlusButton)
        NSLayoutConstraint.activate([
            photosStepperPlusButton.topAnchor.constraint(equalTo: photosStepperContainerUIView.topAnchor),
            photosStepperPlusButton.trailingAnchor.constraint(equalTo: photosStepperContainerUIView.trailingAnchor),
            photosStepperPlusButton.bottomAnchor.constraint(equalTo: photosStepperContainerUIView.bottomAnchor),
            photosStepperPlusButton.widthAnchor.constraint(equalToConstant: 30)
            ])
    }

    private func setupPhotosStepperLabel() {
        photosStepperContainerUIView.addSubview(photosStepperLabel)
        NSLayoutConstraint.activate([
            photosStepperLabel.topAnchor.constraint(equalTo: photosStepperContainerUIView.topAnchor),
            photosStepperLabel.leadingAnchor.constraint(equalTo: photosStepperMinusButton.trailingAnchor),
            photosStepperLabel.trailingAnchor.constraint(equalTo: photosStepperPlusButton.leadingAnchor),
            photosStepperLabel.bottomAnchor.constraint(equalTo: photosStepperContainerUIView.bottomAnchor)
            ])
    }

    private func setupPhotosColorBar() {
        addSubview(photosColorBarUIView)
        NSLayoutConstraint.activate([
            photosColorBarUIView.topAnchor.constraint(equalTo: photosStepperContainerUIView.bottomAnchor, constant: 0),
            photosColorBarUIView.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 16),
            photosColorBarUIView.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -16),
            photosColorBarUIView.heightAnchor.constraint(equalToConstant: 2.5),
            ])
    }

    private func setupSecondsStepperContainer() {
        addSubview(timerStepperContainerUIView)
        NSLayoutConstraint.activate([
            timerStepperContainerUIView.topAnchor.constraint(equalTo: photosColorBarUIView.bottomAnchor, constant: 30),
            timerStepperContainerUIView.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 16),
            timerStepperContainerUIView.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -16),
            timerStepperContainerUIView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupTimerMinusButton() {
        timerStepperContainerUIView.addSubview(timerStepperMinusButton)
        NSLayoutConstraint.activate([
            timerStepperMinusButton.topAnchor.constraint(equalTo: timerStepperContainerUIView.topAnchor),
            timerStepperMinusButton.leadingAnchor.constraint(equalTo: timerStepperContainerUIView.leadingAnchor),
            timerStepperMinusButton.bottomAnchor.constraint(equalTo: timerStepperContainerUIView.bottomAnchor),
            timerStepperMinusButton.widthAnchor.constraint(equalToConstant: 30)
            ])
    }

    private func setupTimerPlusButton() {
        timerStepperContainerUIView.addSubview(timerStepperPlusButton)
        NSLayoutConstraint.activate([
            timerStepperPlusButton.topAnchor.constraint(equalTo: timerStepperContainerUIView.topAnchor),
            timerStepperPlusButton.trailingAnchor.constraint(equalTo: timerStepperContainerUIView.trailingAnchor),
            timerStepperPlusButton.bottomAnchor.constraint(equalTo: timerStepperContainerUIView.bottomAnchor),
            timerStepperPlusButton.widthAnchor.constraint(equalToConstant: 30)
            ])
    }

    private func setupTimerStepperLabel() {
        timerStepperContainerUIView.addSubview(timerStepperLabel)
        NSLayoutConstraint.activate([
            timerStepperLabel.topAnchor.constraint(equalTo: timerStepperContainerUIView.topAnchor),
            timerStepperLabel.leadingAnchor.constraint(equalTo: timerStepperMinusButton.trailingAnchor),
            timerStepperLabel.trailingAnchor.constraint(equalTo: timerStepperPlusButton.leadingAnchor),
            timerStepperLabel.bottomAnchor.constraint(equalTo: timerStepperContainerUIView.bottomAnchor)
            ])
    }

    private func setupTimerColorBar() {
        addSubview(timerColorBarUIView)
        NSLayoutConstraint.activate([
            timerColorBarUIView.topAnchor.constraint(equalTo: timerStepperContainerUIView.bottomAnchor, constant: 0),
            timerColorBarUIView.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 16),
            timerColorBarUIView.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -16),
            timerColorBarUIView.heightAnchor.constraint(equalToConstant: 2.5),
            ])
    }

    private func setupStartShootButton() {
        addSubview(startShootButton)
        NSLayoutConstraint.activate([
            startShootButton.topAnchor.constraint(equalTo: timerColorBarUIView.bottomAnchor, constant: 55),
            startShootButton.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 16),
            startShootButton.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -16),
            startShootButton.heightAnchor.constraint(equalToConstant: 40),
            startShootButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.6),
            startShootButton.bottomAnchor.constraint(lessThanOrEqualTo: cardUIView.bottomAnchor, constant: -55)
            ])
    }
}

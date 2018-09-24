import UIKit

class PhotoShootSetupCard: UIView {

    let fontRegular = "AvenirNext-Regular"
    let fontBold = "AvenirNext-Bold"

    let photoBoothBlue = UIColor(red: 38/225, green: 185/225, blue: 224/225, alpha: 1)

    lazy var cardUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
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

    lazy var numberOfPhotosButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: fontRegular, size: 16)
        button.setTitle("# of pictures", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .white
        button.titleLabel?.numberOfLines = 1
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

    lazy var timerDelayButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: fontRegular, size: 16)
        button.setTitle("seconds between shots", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .white
        button.titleLabel?.numberOfLines = 1
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
        setupNumberOfPhotosButton()
        setupPhotosColorBar()
        setupTimerDelayButton()
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

    private func setupNumberOfPhotosButton() {
        addSubview(numberOfPhotosButton)
        NSLayoutConstraint.activate([
            numberOfPhotosButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            numberOfPhotosButton.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 16),
            numberOfPhotosButton.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -16),
            numberOfPhotosButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupPhotosColorBar() {
        addSubview(photosColorBarUIView)
        NSLayoutConstraint.activate([
            photosColorBarUIView.topAnchor.constraint(equalTo: numberOfPhotosButton.bottomAnchor, constant: 0),
            photosColorBarUIView.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 16),
            photosColorBarUIView.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -16),
            photosColorBarUIView.heightAnchor.constraint(equalToConstant: 2.5),
            ])
    }

    private func setupTimerDelayButton() {
        addSubview(timerDelayButton)
        NSLayoutConstraint.activate([
            timerDelayButton.topAnchor.constraint(equalTo: photosColorBarUIView.bottomAnchor, constant: 30),
            timerDelayButton.leadingAnchor.constraint(equalTo: cardUIView.leadingAnchor, constant: 16),
            timerDelayButton.trailingAnchor.constraint(equalTo: cardUIView.trailingAnchor, constant: -16),
            timerDelayButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupTimerColorBar() {
        addSubview(timerColorBarUIView)
        NSLayoutConstraint.activate([
            timerColorBarUIView.topAnchor.constraint(equalTo: timerDelayButton.bottomAnchor, constant: 0),
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

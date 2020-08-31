import UIKit

class InterstitialView: UIView {
    var viewModel: InterstitialViewModeling = InterstitialViewModel()

    // MARK: - Objects
    lazy var launchscreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: StyleGuide.Assets.launchScreen)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .photoBoothBlue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.versionText
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.regularFont(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func startLoad() {
        activityIndicator.startAnimating()
    }

    func endLoad() {
        activityIndicator.stopAnimating()
    }

    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    // MARK: - Setup Methods
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        startLoad()
    }

    private func setupViews() {
        setupLaunchScreenImageView()
        setupActivityIndicator()
        setupVersionLabel()
    }

    // MARK: - Constraints
    private func setupLaunchScreenImageView() {
        addSubview(launchscreenImageView)
        NSLayoutConstraint.activate([
            launchscreenImageView.topAnchor.constraint(equalTo: topAnchor),
            launchscreenImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            launchscreenImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            launchscreenImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: StyleGuide.StaticAppNumbers.heightConstant),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 44),
            activityIndicator.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupVersionLabel() {
        addSubview(versionLabel)
        NSLayoutConstraint.activate([
            versionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            versionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            versionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ])
    }
}

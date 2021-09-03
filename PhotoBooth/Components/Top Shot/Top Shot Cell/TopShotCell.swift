import UIKit

class TopShotCell: UICollectionViewCell {
    var viewModel: TopShotCellViewModeling = TopShotCellViewModel(images: [UIImage()])

    var textColor: UIColor?

    lazy var photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .center
        photo.backgroundColor = .clear
        photo.contentMode = .scaleAspectFill
        photo.layer.masksToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var selectedPhotoIcon: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFit
        photo.layer.cornerRadius = 15
        photo.layer.masksToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    lazy var labelBlur: UIView = {
        let view = UIView()
        view.addBlurEffect(blurStyle: .regular)
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var labelShimmerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var topShotLabel: UILabel = {
        let label = UILabel()
        label.text = StyleGuide.AppCopy.ReviewVC.topShotText
        label.textColor = textColor
        label.font = UIFont.regularFont(size: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var topShotLabelIcon: UIImageView = {
        let image = UIImage(named: StyleGuide.Assets.appLogo)
        let iv = UIImageView()
        iv.image = image
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    lazy var blurView: UIView = {
        let view = UIView()
        view.addBlurEffect(blurStyle: .regular)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .photoBoothBlue
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    var imageReceived: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            switch self.traitCollection.userInterfaceStyle {
            case .light:
                textColor = .darkGray
            case .dark:
                textColor = .white
            case .unspecified:
                textColor = .white
            @unknown default:
                textColor = .white
            }
        }
    }

    func setUI() {
        switch UITraitCollection.current.userInterfaceStyle {
        case .light:
            textColor = .darkGray
        case .dark:
            textColor = .white
        case .unspecified:
            textColor = .white
        @unknown default:
            textColor = .white
        }
    }

    func isSpinnerActive(state: Bool) {
        switch state {
        case true:
            activityIndicator.startAnimating()
        case false:
            activityIndicator.stopAnimating()
            blurView.isHidden = true
        }
    }

    func set(viewModel: TopShotCellViewModeling) {
        self.viewModel = viewModel
        self.viewModel.onSelectionChanged = { [weak self] in
            self?.updateUI()
        }

        updateUI()
        bindUI()
    }

    func animateShimmer() {
        DispatchQueue.main.asyncAfter(deadline:
        .now() + StyleGuide.StaticAppNumbers.shimmerDelay) {
            let shimmerMask = UIView(frame: self.labelShimmerView.bounds)
            shimmerMask.layer.cornerRadius = self.labelShimmerView.layer.cornerRadius
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .repeat,
                           animations: {
                            self.labelShimmerView.animateShimmer(
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

    private func commonInit() {
        backgroundColor = UIColor.clear
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupViews() {
        setupPhotoImageView()
        setupSelectedView()
        setupSelectedPhotoIcon()
        setupLabelBlur()
        setupShimerVIew()
        setupTopShotLabel()
        setupTopshotLabelIcon()
        setupBlurView()
        setupActivityIndicator()
    }

    private func setupPhotoImageView() {
        contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }

    private func setupSelectedView() {
        contentView.addSubview(selectedView)
        NSLayoutConstraint.activate([
            selectedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            selectedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }

    private func setupSelectedPhotoIcon() {
        selectedView.addSubview(selectedPhotoIcon)
        NSLayoutConstraint.activate([
            selectedPhotoIcon.trailingAnchor.constraint(equalTo: selectedView.trailingAnchor, constant: -10),
            selectedPhotoIcon.heightAnchor.constraint(equalToConstant: 30),
            selectedPhotoIcon.widthAnchor.constraint(equalToConstant: 30),
            selectedPhotoIcon.bottomAnchor.constraint(equalTo: selectedView.bottomAnchor, constant: -10)
            ])
    }

    private func setupLabelBlur() {
        contentView.addSubview(labelBlur)
        NSLayoutConstraint.activate([
            labelBlur.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelBlur.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelBlur.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.4),
            labelBlur.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func setupShimerVIew() {
        labelBlur.addSubview(labelShimmerView)
        NSLayoutConstraint.activate([
            labelShimmerView.topAnchor.constraint(equalTo: labelBlur.topAnchor),
            labelShimmerView.leadingAnchor.constraint(equalTo: labelBlur.leadingAnchor),
            labelShimmerView.trailingAnchor.constraint(equalTo: labelBlur.trailingAnchor),
            labelShimmerView.bottomAnchor.constraint(equalTo: labelBlur.bottomAnchor)
        ])
    }

    private func setupTopShotLabel() {
        labelBlur.addSubview(topShotLabel)
        NSLayoutConstraint.activate([
            topShotLabel.topAnchor.constraint(equalTo: labelBlur.topAnchor),
            topShotLabel.leadingAnchor.constraint(equalTo: labelBlur.leadingAnchor, constant: 8),
            topShotLabel.bottomAnchor.constraint(equalTo: labelBlur.bottomAnchor)
        ])
    }

    private func setupTopshotLabelIcon() {
        labelBlur.addSubview(topShotLabelIcon)
        NSLayoutConstraint.activate([
            topShotLabelIcon.topAnchor.constraint(equalTo: labelBlur.topAnchor, constant: 2),
            topShotLabelIcon.leadingAnchor.constraint(equalTo: topShotLabel.trailingAnchor, constant: 2),
            topShotLabelIcon.trailingAnchor.constraint(equalTo: labelBlur.trailingAnchor, constant: -4),
            topShotLabelIcon.heightAnchor.constraint(equalToConstant: 22),
            topShotLabelIcon.widthAnchor.constraint(equalToConstant: 22)
        ])
    }

    private func setupBlurView() {
        addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurView.centerYAnchor.constraint(equalTo: centerYAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 32),
            blurView.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func setupActivityIndicator() {
        blurView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 44),
            activityIndicator.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func updateUI() {
        selectedView.backgroundColor = UIColor.white.withAlphaComponent(viewModel.selectionAlpha)
        selectedPhotoIcon.image = viewModel.getSelectionImage()
        isSpinnerActive(state: viewModel.isSpinnerActive)
    }

    private func bindUI() {
        self.viewModel.imageDidUpdate = { [weak self] in
            self?.photoImageView.image = self?.viewModel.topShotImage
            self?.updateUI()
            self?.imageReceived?()
        }
    }
}

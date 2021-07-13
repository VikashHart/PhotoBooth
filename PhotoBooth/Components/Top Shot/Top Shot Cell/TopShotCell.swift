import UIKit

class TopShotCell: UICollectionViewCell {
    var viewModel: TopShotCellViewModeling = TopShotCellViewModel(images: [UIImage()])

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

    lazy var topShotLabel: UILabel = {
        let label = UILabel()
        label.text = StyleGuide.AppCopy.ReviewVC.topShotText
        label.textColor = .white
        label.font = UIFont.regularFont(size: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupTopShotLabel()
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
            labelBlur.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            labelBlur.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func setupTopShotLabel() {
        labelBlur.addSubview(topShotLabel)
        NSLayoutConstraint.activate([
            topShotLabel.topAnchor.constraint(equalTo: labelBlur.topAnchor),
            topShotLabel.leadingAnchor.constraint(equalTo: labelBlur.leadingAnchor),
            topShotLabel.trailingAnchor.constraint(equalTo: labelBlur.trailingAnchor),
            topShotLabel.bottomAnchor.constraint(equalTo: labelBlur.bottomAnchor)
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

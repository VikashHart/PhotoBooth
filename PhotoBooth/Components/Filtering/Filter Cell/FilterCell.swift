import UIKit

class FilterCell: UICollectionViewCell {

    //MARK: - Objects
    var viewModel: FilterCellViewModeling = FilterCellViewModel(image: UIImage(),
                                                                filterDesignation: "",
                                                                filterName: "",
                                                                context: CIContext())

    lazy var filterBlurView: UIView = {
        let view = UIView()
        view.addBlurEffect(blurStyle: .dark)
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.regularFont(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var filterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        commonInit()
        bindUI()
        bindImageStatus()
        updateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    //MARK: - Set up methods
    private func commonInit() {
        backgroundColor = UIColor.black
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func showBorder() {
        self.filterImageView.layer.borderWidth = 2
        self.filterImageView.layer.borderColor = UIColor.white.cgColor
    }

    private func hideBorder() {
        self.filterImageView.layer.borderWidth = 0
        self.filterImageView.layer.borderColor = UIColor.clear.cgColor
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

    func setViewModel(viewModel: FilterCellViewModeling) {
        self.viewModel = viewModel
        bindUI()
        bindImageStatus()
        updateUI()
    }

    private func setupViews() {
        setupFilterImageView()
        setupFilterBlurView()
        setupFilterLabel()
        setupBlurView()
        setupActivityIndicator()
    }

    //MARK: - Constraints

    private func setupFilterImageView() {
        addSubview(filterImageView)
        NSLayoutConstraint.activate([
            filterImageView.topAnchor.constraint(equalTo: topAnchor),
            filterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupFilterBlurView() {
        filterImageView.addSubview(filterBlurView)
        NSLayoutConstraint.activate([
            filterBlurView.leadingAnchor.constraint(equalTo: filterImageView.leadingAnchor),
            filterBlurView.trailingAnchor.constraint(equalTo: filterImageView.trailingAnchor),
            filterBlurView.heightAnchor.constraint(equalToConstant: 22),
            filterBlurView.bottomAnchor.constraint(equalTo: filterImageView.bottomAnchor)
        ])
    }

    private func setupFilterLabel() {
        filterBlurView.addSubview(filterLabel)
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: filterBlurView.topAnchor, constant: 2),
            filterLabel.leadingAnchor.constraint(equalTo: filterBlurView.leadingAnchor, constant: 2),
            filterLabel.trailingAnchor.constraint(equalTo: filterBlurView.trailingAnchor, constant: -2),
            filterLabel.bottomAnchor.constraint(equalTo: filterBlurView.bottomAnchor, constant: -2)
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
        filterImageView.image = viewModel.imageObject
        filterLabel.text = viewModel.filterName
        switch self.viewModel.isSelected {
        case true:
            showBorder()
        case false:
            hideBorder()
        }
        isSpinnerActive(state: self.viewModel.isSpinnerActive)
        layoutIfNeeded()
    }

    private func bindUI() {
        self.viewModel.isSelectedChanged = { [weak self] in
            self?.updateUI()
        }
    }

    private func bindImageStatus() {
        self.viewModel.imageDidUpdate = { [weak self] in
            self?.updateUI()
        }
    }
}


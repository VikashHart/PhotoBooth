import UIKit

class ReviewCell: UICollectionViewCell {

    var viewModel: ReviewCellModeling = ReviewCellViewModel(image: UIImage()) {
        didSet {
            viewModel.onSelectionChanged = { [weak self] in
                self?.updateUI()
            }
            updateUI()
        }
    }

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
        let image = UIImage(named: "selected_icon")?.withRenderingMode(.alwaysTemplate)
        photo.image = image
        photo.tintColor = UIColor.photoBoothBlue.withAlphaComponent(1.0)
        photo.contentMode = .scaleAspectFit
        photo.backgroundColor = .white
        photo.layer.borderWidth = 3
        photo.layer.borderColor = UIColor.white.cgColor
        photo.layer.cornerRadius = 20
        photo.layer.masksToBounds = true
        photo.isHidden = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func commonInit() {
        backgroundColor = UIColor.white
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupViews() {
        setupPhotoImageView()
        setupSelectedView()
        setupSelectedPhotoIcon()
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
            selectedPhotoIcon.heightAnchor.constraint(equalToConstant: 40),
            selectedPhotoIcon.widthAnchor.constraint(equalToConstant: 40),
            selectedPhotoIcon.bottomAnchor.constraint(equalTo: selectedView.bottomAnchor, constant: -10)
            ])
    }

    private func updateUI() {
        photoImageView.image = viewModel.image
        selectedView.backgroundColor = UIColor.white.withAlphaComponent(viewModel.selectionAlpha)
        selectedPhotoIcon.isHidden = viewModel.hidePhotoIcon
    }
}

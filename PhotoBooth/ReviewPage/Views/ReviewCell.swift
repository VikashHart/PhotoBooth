import UIKit

class ReviewCell: UICollectionViewCell {

    var viewModel: ReviewCellModeling = ReviewCellViewModel(image: UIImage())

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func set(viewModel: ReviewCellModeling) {
        self.viewModel = viewModel
        self.viewModel.onSelectionChanged = { [weak self] in
            self?.updateUI()
        }

        updateUI()
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
            selectedPhotoIcon.heightAnchor.constraint(equalToConstant: 30),
            selectedPhotoIcon.widthAnchor.constraint(equalToConstant: 30),
            selectedPhotoIcon.bottomAnchor.constraint(equalTo: selectedView.bottomAnchor, constant: -10)
            ])
    }

    private func updateUI() {
        photoImageView.image = viewModel.image
        selectedView.backgroundColor = UIColor.white.withAlphaComponent(viewModel.selectionAlpha)
        selectedPhotoIcon.image = viewModel.getSelectionImage()
    }
}

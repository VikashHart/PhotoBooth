import UIKit

class ReviewCell: UICollectionViewCell {

    var viewModel: ReviewCellModeling = ReviewCellViewModel(image: UIImage())

    lazy var photoImageView: UIImageView = {
        let photo = UIImageView()
        let image = viewModel.image
        photo.image = image
        photo.contentMode = .center
        photo.backgroundColor = .clear
        photo.contentMode = .scaleAspectFill
        photo.layer.masksToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    lazy var selectedUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var selectedPhotoIcon: UIImageView = {
        let photo = UIImageView()
        let image = UIImage(named: "selected_icon")?.withRenderingMode(.alwaysTemplate)
        photo.image = image
        photo.tintColor = UIColor.photoBoothBlue.withAlphaComponent(1.0)
        photo.contentMode = .center
        photo.backgroundColor = .white
        photo.layer.borderWidth = 2
        photo.layer.borderColor = UIColor.white.cgColor
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
        addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupSelectedView() {
        addSubview(selectedUIView)
        NSLayoutConstraint.activate([
            selectedUIView.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            selectedUIView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            selectedUIView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),
            selectedUIView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor)
            ])
    }

    private func setupSelectedPhotoIcon() {
        selectedUIView.addSubview(selectedPhotoIcon)
        NSLayoutConstraint.activate([
            selectedPhotoIcon.trailingAnchor.constraint(equalTo: selectedUIView.trailingAnchor, constant: -20),
            selectedPhotoIcon.bottomAnchor.constraint(equalTo: selectedUIView.bottomAnchor, constant: -10)
            ])
    }
}

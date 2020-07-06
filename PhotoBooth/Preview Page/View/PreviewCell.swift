import UIKit

class PreviewCell: UICollectionViewCell {

    var viewModel: PreviewCellModeling = PreviewCellViewModel(cellImage: UIImage()) {
        didSet {
            updateUI()
        }
    }

    lazy var photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.image = self.viewModel.cellImage
        photo.contentMode = .center
        photo.backgroundColor = .clear
        photo.contentMode = .scaleAspectFill
        photo.layer.masksToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        bindUI()
        updateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func showBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }

    private func hideBorder() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }

    private func commonInit() {
        setupViews()
        configureView()
    }

    private func configureView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupViews() {
        setupPhotoImageView()
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

    private func updateUI() {
        photoImageView.image = viewModel.cellImage
        switch self.viewModel.isSelected {
        case true:
            showBorder()
        case false:
            hideBorder()
        }
    }

    private func bindUI() {
        viewModel.isSelectedChanged = { [weak self] in
            self?.updateUI()
        }
    }
}

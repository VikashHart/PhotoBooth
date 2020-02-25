import UIKit

class BackdropCell: UICollectionViewCell {

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.semiBoldFont(size: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.white
        setupViews()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupViews() {
        setupContainer()
        setupImageView()
        setupLabel()
    }

    private func setupContainer() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupImageView() {
        containerView.addSubview(cellImageView)
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cellImageView.heightAnchor.constraint(equalTo: widthAnchor)
            ])
    }

    private func setupLabel() {
        containerView.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cellLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
    }
}

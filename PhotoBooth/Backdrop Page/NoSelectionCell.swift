import UIKit

class NoSelectionCell: UICollectionViewCell {

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.font = UIFont.mediumFont(size: 30)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.photoBoothBlue
        setupViews()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupViews() {
        setupLabel()
    }

    private func setupLabel() {
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

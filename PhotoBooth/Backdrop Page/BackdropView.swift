import UIKit

class BackdropView: UIView {

    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.photoBoothBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Backdrop"
        label.font = UIFont.semiBoldFont(size: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 18)
        button.setTitle("Done", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let noSelectionCell = "NoSelectionCell"
    let backdropCell = "BackdropCell"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(NoSelectionCell.self, forCellWithReuseIdentifier: noSelectionCell)
        collectionView.register(BackdropCell.self, forCellWithReuseIdentifier: backdropCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        setupHeader()
        setupDoneButton()
        setupHeaderTitleLabel()
        setupCollectionView()
    }

    private func setupHeader() {
        addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44)
            ])
    }

    private func setupDoneButton() {
        headerView.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
            ])
    }

    private func setupHeaderTitleLabel() {
        headerView.addSubview(headerTitleLabel)
        NSLayoutConstraint.activate([
            headerTitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            ])
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

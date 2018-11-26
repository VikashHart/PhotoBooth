import UIKit

class ReviewPageView: UIView {

    lazy var navBarUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.photoBoothBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 18)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pictures"
        label.font = UIFont.semiBoldFont(size: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var selectButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 18)
        button.setTitle("Select", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 16)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.opacity = 1
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let cell = "ReviewCell"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shareButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "share_icon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .clear
        button.layer.opacity = 1
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        setupNavBarView()
        setupCancelButton()
        setupTitleLabel()
        setupSelectButton()
        setupDoneButton()
        setupCollectionView()
        setupFooterView()
        setupShareButton()
    }

    private func setupNavBarView() {
        addSubview(navBarUIView)
        NSLayoutConstraint.activate([
            navBarUIView.topAnchor.constraint(equalTo: topAnchor),
            navBarUIView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBarUIView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBarUIView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
            ])
    }

    private func setupCancelButton() {
        navBarUIView.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: navBarUIView.safeAreaLayoutGuide.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: navBarUIView.leadingAnchor, constant: 10)
            ])
    }

    private func setupTitleLabel() {
        navBarUIView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: navBarUIView.widthAnchor, multiplier: 0.5),
            titleLabel.centerXAnchor.constraint(equalTo: navBarUIView.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: navBarUIView.safeAreaLayoutGuide.centerYAnchor)
            ])
    }

    private func setupSelectButton() {
        navBarUIView.addSubview(selectButton)
        NSLayoutConstraint.activate([
            selectButton.centerYAnchor.constraint(equalTo: navBarUIView.safeAreaLayoutGuide.centerYAnchor),
            selectButton.trailingAnchor.constraint(equalTo: navBarUIView.trailingAnchor, constant: -10)
            ])
    }

    private func setupDoneButton() {
        navBarUIView.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.centerYAnchor.constraint(equalTo: navBarUIView.safeAreaLayoutGuide.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: navBarUIView.trailingAnchor, constant: -10)
            ])
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navBarUIView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9)
            ])
    }

    private func setupFooterView() {
        addSubview(footerView)
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 44),
            footerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    private func setupShareButton() {
        footerView.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            shareButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 35),
            shareButton.widthAnchor.constraint(equalToConstant: 35)
            ])
    }
}


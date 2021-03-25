import UIKit
import PromiseKit

class PreviewView: UIView {

    let viewModel: PreviewViewModel

    lazy var backButtonContainer: UIView = {
        let view = UIView()
        view.addBlurEffect(blurStyle: .light)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.layer.cornerRadius = 17.5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 18)
        button.setTitle(StyleGuide.AppCopy.PreviewVC.backButtonText, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var imageScrollView: UIScrollView = {
        let view = UIScrollView()
        view.bounces = true
        view.bouncesZoom = true
        view.maximumZoomScale = 2.5
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = viewModel.selectedImage
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var collectionViewContainer: UIView = {
        let view = UIView()
        view.addBlurEffect(blurStyle: .light)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var toolbarView: ToolbarView = {
        let view = ToolbarView()
        view.addFilterFunctionality()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: StyleGuide.CollectionView.PreviewPage.previewCellId)
        collectionView.register(FilterCell.self, forCellWithReuseIdentifier: StyleGuide.CollectionView.PreviewPage.filterCellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var saveAnimationView: SaveIndicator = {
        let view = SaveIndicator()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var imageViewTopConstraint: NSLayoutConstraint?
    private var imageViewBottomConstraint: NSLayoutConstraint?
    private var imageViewLeadingConstraint: NSLayoutConstraint?
    private var imageViewTrailingConstraint: NSLayoutConstraint?

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: PreviewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
        bindUiToViewModel()
    }

    private func overlayActivate() {
        self.backButtonContainer.isHidden = false
        self.toolbarView.isHidden = false
        self.collectionViewContainer.isHidden = false
    }

    private func overlayDeactivate() {
        self.backButtonContainer.isHidden = true
        self.toolbarView.isHidden = true
        self.collectionViewContainer.isHidden = true
    }

    func updateImageViewXYValues(x: CGFloat, y: CGFloat) {
        imageViewLeadingConstraint?.constant = x
        imageViewTrailingConstraint?.constant = x
        imageViewTopConstraint?.constant = y
        imageViewBottomConstraint?.constant = y

        layoutIfNeeded()
    }

    func showOverlay(_ visibile: Bool) {
        switch visibile {
        case true:
            self.overlayActivate()
        case false:
            self.overlayDeactivate()
        }

        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }

    func showSaveIndicator() -> Guarantee<Void> {
        return UIView.promiseAnimation(withDuration: 0.2) {
            self.saveAnimationView.isHidden = false
        }
        .then(self.saveAnimationView.playAnimation)
        .done { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                UIView.animate(withDuration: 0.2) {
                    self.saveAnimationView.isHidden = true
                }
            }
            self.playHaptic()
        }
    }

    func deactivateToolbar() {
        toolbarView.deactivateButtons()
    }

    func activateToolbar() {
        toolbarView.activateButtons()
    }

    private func playHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(StyleGuide.HapticFeedbackType.savedFeedbackStyle)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
    }

    private func commonInit() {
        backgroundColor = .black
        setupViews()
    }

    private func setupViews() {
        setupImageScrollView()
        setupPreviewImageView()
        setupBackButtonContainer()
        setupBackButton()
        setupCollectionViewContainer()
        setupCollectionView()
        setupToolbar()
        setupSaveAnimationView()
    }

    private func setupImageScrollView() {
        addSubview(imageScrollView)
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupPreviewImageView() {
        imageScrollView.addSubview(imageView)

        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: imageScrollView.topAnchor)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor)
        imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor)
        imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor)

        guard let top = imageViewTopConstraint,
            let leading = imageViewLeadingConstraint,
            let trailing = imageViewTrailingConstraint,
            let bottom = imageViewBottomConstraint
            else {
                return
        }

        NSLayoutConstraint.activate([
            top,
            leading,
            trailing,
            bottom
        ])
    }

    private func setupBackButtonContainer() {
        addSubview(backButtonContainer)
        NSLayoutConstraint.activate([
            backButtonContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButtonContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButtonContainer.heightAnchor.constraint(equalToConstant: 35),
            backButtonContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15)
        ])
    }

    private func setupBackButton() {
        backButtonContainer.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: backButtonContainer.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: backButtonContainer.centerYAnchor)
            ])
    }

    private func setupCollectionViewContainer() {
        addSubview(collectionViewContainer)
        NSLayoutConstraint.activate([
            collectionViewContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            collectionViewContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionViewContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }

    private func setupCollectionView() {
        collectionViewContainer.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }

    private func setupToolbar() {
        addSubview(toolbarView)
        NSLayoutConstraint.activate([
            toolbarView.bottomAnchor.constraint(equalTo: collectionViewContainer.topAnchor, constant: -8),
            toolbarView.heightAnchor.constraint(equalToConstant: 55),
            toolbarView.widthAnchor.constraint(equalToConstant: 170),
            toolbarView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupSaveAnimationView() {
        addSubview(saveAnimationView)
        NSLayoutConstraint.activate([
            saveAnimationView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            saveAnimationView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            saveAnimationView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            saveAnimationView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func updateUI() {
        self.imageView.image = viewModel.selectedImage
    }

    private func bindUiToViewModel() {
        viewModel.onImageChanged = { [weak self] in
            self?.updateUI()
        }
    }
}

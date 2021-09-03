import UIKit
import RxSwift
import PromiseKit

class ReviewPageView: UIView {

    var viewModel: ReviewPageViewModeling = ReviewPageViewModel(selectionCountObservable:  Observable.just(0)) {
        didSet {
            updateUI()
        }
    }

    lazy var gradientView: GradientView = {
        let view = GradientView()
        view.gradientLayer?.startPoint = CGPoint(x: 0.2, y: 0)
        view.gradientLayer?.endPoint = CGPoint(x: 0.8, y: 1)
        view.gradientLayer?.colors = CGColor.blacks
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var navbarContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.photoBoothMed.withAlphaComponent(0.4)
        view.addBlurEffect(blurStyle: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var navBarUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 18)
        button.setTitle(StyleGuide.AppCopy.ReviewVC.exitButtonText, for: .normal)
        button.backgroundColor = .clear
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.semiBoldFont(size: 24)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var selectButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 18)
        button.setTitle(StyleGuide.AppCopy.ReviewVC.selectButtonText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.semiBoldFont(size: 18)
        button.setTitle(StyleGuide.AppCopy.ReviewVC.doneButtonText, for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(TopShotCell.self, forCellWithReuseIdentifier: StyleGuide.CollectionView.ReviewPage.topShotCellId)
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: StyleGuide.CollectionView.ReviewPage.reviewCellId)
        collectionView.contentInset = UIEdgeInsets(top: 44,left: 0,bottom: 0,right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 44,left: 0,bottom: 0,right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var toolbarView: ToolbarView = {
        let view = ToolbarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var saveAnimationView: SaveIndicator = {
        let view = SaveIndicator()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let headerHeight: CGFloat = UIApplication.shared.statusBarFrame.height + 44

    private var toolbarTopToViewBottom: NSLayoutConstraint?
    private var toolbarBottomToSafeAreaBottom: NSLayoutConstraint?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    init(viewModel: ReviewPageViewModeling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
        bindUiToViewModel()
    }

    private func toolbarActivate() {
        toolbarTopToViewBottom?.isActive = false
        toolbarBottomToSafeAreaBottom?.isActive = true

        collectionView.contentInset = UIEdgeInsets(top: 44,left: 0,bottom: 54,right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 44,left: 0,bottom: 54,right: 0)
    }

    private func toolbarDeactivate() {
        toolbarBottomToSafeAreaBottom?.isActive = false
        toolbarTopToViewBottom?.isActive = true

        collectionView.contentInset = UIEdgeInsets(top: 44,left: 0,bottom: 0,right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 44,left: 0,bottom: 0,right: 0)

    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            setUI()
        }
    }

    func setUI() {
        switch UITraitCollection.current.userInterfaceStyle {
        case .light:
            gradientView.gradientLayer?.colors = CGColor.lights
            cancelButton.setTitleColor(.darkGray, for: .normal)
            selectButton.setTitleColor(.darkGray, for: .normal)
            doneButton.setTitleColor(.darkGray, for: .normal)
            titleLabel.textColor = .darkGray
        case .dark:
            gradientView.gradientLayer?.colors = CGColor.blacks
            cancelButton.setTitleColor(.white, for: .normal)
            selectButton.setTitleColor(.white, for: .normal)
            doneButton.setTitleColor(.white, for: .normal)
            titleLabel.textColor = .white
        case .unspecified:
            gradientView.gradientLayer?.colors = CGColor.blacks
            cancelButton.setTitleColor(.white, for: .normal)
            selectButton.setTitleColor(.white, for: .normal)
            doneButton.setTitleColor(.white, for: .normal)
            titleLabel.textColor = .white
        @unknown default:
            gradientView.gradientLayer?.colors = CGColor.blacks
            cancelButton.setTitleColor(.white, for: .normal)
            selectButton.setTitleColor(.white, for: .normal)
            doneButton.setTitleColor(.white, for: .normal)
            titleLabel.textColor = .white
        }
    }

    func showToolbar(_ visibile: Bool) {
        switch visibile {
        case true:
            self.toolbarActivate()
        case false:
            self.toolbarDeactivate()
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

    private func commonInit() {
        backgroundColor = .white
        setUI()
        setupViews()
    }

    private func setupViews() {
        setupGradientView()
        setupCollectionView()
        setupNavbarContainer()
        setupNavBarView()
        setupCancelButton()
        setupTitleLabel()
        setupSelectButton()
        setupDoneButton()
        setupToolbarView()
        setupSaveAnimationView()
    }

    private func setupGradientView() {
        addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupNavbarContainer() {
        addSubview(navbarContainer)
        NSLayoutConstraint.activate([
            navbarContainer.topAnchor.constraint(equalTo: topAnchor),
            navbarContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            navbarContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            navbarContainer.heightAnchor.constraint(equalToConstant: headerHeight)
        ])
    }

    private func setupNavBarView() {
        navbarContainer.addSubview(navBarUIView)
        NSLayoutConstraint.activate([
            navBarUIView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navBarUIView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBarUIView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBarUIView.heightAnchor.constraint(equalToConstant: 44)
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
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    private func setupToolbarView() {
        addSubview(toolbarView)

        toolbarTopToViewBottom = toolbarView.topAnchor.constraint(equalTo: bottomAnchor)
        toolbarBottomToSafeAreaBottom = toolbarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4)

        NSLayoutConstraint.activate([
            toolbarView.widthAnchor.constraint(equalToConstant: 150),
            toolbarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            toolbarView.heightAnchor.constraint(equalToConstant: 50)
            ])
        toolbarTopToViewBottom?.isActive = true
    }

    private func setupSaveAnimationView() {
        addSubview(saveAnimationView)
        NSLayoutConstraint.activate([
            saveAnimationView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            saveAnimationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            saveAnimationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            saveAnimationView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func updateUI() {
        cancelButton.isHidden = viewModel.isCancelHidden
        selectButton.isHidden = viewModel.isSelectHidden
        doneButton.isHidden = viewModel.isDoneHidden
        titleLabel.text = viewModel.headerText
    }

    private func bindUiToViewModel() {
        viewModel.onSelectChanged = { [weak self] in
            self?.updateUI()
        }
    }
}

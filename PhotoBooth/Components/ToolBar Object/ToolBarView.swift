import UIKit

class ToolbarView: UIView {

    weak var delegate: ToolbarDelegate?

    //MARK: - Objects
    lazy var blurContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addBlurEffect(blurStyle: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shareContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var saveContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var filterContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = true
        button.addTarget(self,
                         action: #selector(shareTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = true
        button.addTarget(self,
                         action: #selector(saveTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = true
        button.addTarget(self,
                         action: #selector(filterTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var shareIcon: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: StyleGuide.Assets.shareIcon)?.withRenderingMode(.alwaysTemplate)
        view.image = image
        view.tintColor = .white
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var saveIcon: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: StyleGuide.Assets.saveIcon)?.withRenderingMode(.alwaysTemplate)
        view.image = image
        view.tintColor = .white
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var filterIcon: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: StyleGuide.Assets.filteringIcon)?.withRenderingMode(.alwaysTemplate)
        view.image = image
        view.tintColor = .white
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shareTitle: UILabel = {
        let label = UILabel()
        label.text = StyleGuide.AppCopy.Toolbar.shareText
        label.textColor = .white
        label.font = UIFont.regularFont(size: 15)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var saveTitle: UILabel = {
        let label = UILabel()
        label.text = StyleGuide.AppCopy.Toolbar.saveText
        label.textColor = .white
        label.font = UIFont.regularFont(size: 15)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var filterTitle: UILabel = {
        let label = UILabel()
        label.text = StyleGuide.AppCopy.Toolbar.filterText
        label.textColor = .white
        label.font = UIFont.regularFont(size: 15)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    //MARK: - Setup Methods
    private func commonInit() {
        configureView()
        setupViews()
    }

    private func configureView() {
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
    }

    private func setupViews() {
        setupBlurView()
        setupStackView()
        setupShareContainer()
        setupShareIcon()
        setupShareTitle()
        setupShareButton()
        setupSaveContainer()
        setupSaveIcon()
        setupSaveTitle()
        setupSaveButton()
    }

    //MARK: - Constraints
    private func setupBlurView() {
        addSubview(blurContainer)
        NSLayoutConstraint.activate([
            blurContainer.topAnchor.constraint(equalTo: topAnchor),
            blurContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupStackView() {
        blurContainer.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: blurContainer.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: blurContainer.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: blurContainer.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: blurContainer.bottomAnchor)
        ])
    }

    private func setupShareContainer() {
        stackView.addArrangedSubview(shareContainer)
    }

    private func setupShareIcon() {
        shareContainer.addSubview(shareIcon)
        NSLayoutConstraint.activate([
            shareIcon.topAnchor.constraint(equalTo: shareContainer.topAnchor, constant: 8),
            shareIcon.leadingAnchor.constraint(equalTo: shareContainer.leadingAnchor),
            shareIcon.trailingAnchor.constraint(equalTo: shareContainer.trailingAnchor)
        ])
    }

    private func setupShareTitle() {
        shareContainer.addSubview(shareTitle)
        NSLayoutConstraint.activate([
            shareTitle.topAnchor.constraint(equalTo: shareIcon.bottomAnchor),
            shareTitle.leadingAnchor.constraint(equalTo: shareContainer.leadingAnchor),
            shareTitle.trailingAnchor.constraint(equalTo: shareContainer.trailingAnchor),
            shareTitle.heightAnchor.constraint(equalToConstant: 20),
            shareTitle.bottomAnchor.constraint(equalTo: shareContainer.bottomAnchor, constant: -4)
        ])
    }

    private func setupShareButton() {
        shareContainer.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: shareContainer.topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: shareContainer.leadingAnchor),
            shareButton.trailingAnchor.constraint(equalTo: shareContainer.trailingAnchor),
            shareButton.bottomAnchor.constraint(equalTo: shareContainer.bottomAnchor)
        ])
    }

    private func setupSaveContainer() {
        stackView.addArrangedSubview(saveContainer)
    }

    private func setupSaveIcon() {
        saveContainer.addSubview(saveIcon)
        NSLayoutConstraint.activate([
            saveIcon.topAnchor.constraint(equalTo: saveContainer.topAnchor, constant: 8),
            saveIcon.leadingAnchor.constraint(equalTo: saveContainer.leadingAnchor),
            saveIcon.trailingAnchor.constraint(equalTo: saveContainer.trailingAnchor)
        ])
    }

    private func setupSaveTitle() {
        saveContainer.addSubview(saveTitle)
        NSLayoutConstraint.activate([
            saveTitle.topAnchor.constraint(equalTo: saveIcon.bottomAnchor),
            saveTitle.leadingAnchor.constraint(equalTo: saveContainer.leadingAnchor),
            saveTitle.trailingAnchor.constraint(equalTo: saveContainer.trailingAnchor),
            saveTitle.heightAnchor.constraint(equalToConstant: 20),
            saveTitle.bottomAnchor.constraint(equalTo: saveContainer.bottomAnchor, constant: -4)
        ])
    }

    private func setupSaveButton() {
        saveContainer.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: saveContainer.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: saveContainer.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: saveContainer.trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: saveContainer.bottomAnchor)
        ])
    }

    private func setupFilterContainer() {
        stackView.addArrangedSubview(filterContainer)
    }

    private func setupFilterIcon() {
        filterContainer.addSubview(filterIcon)
        NSLayoutConstraint.activate([
            filterIcon.topAnchor.constraint(equalTo: filterContainer.topAnchor, constant: 8),
            filterIcon.leadingAnchor.constraint(equalTo: filterContainer.leadingAnchor),
            filterIcon.trailingAnchor.constraint(equalTo: filterContainer.trailingAnchor)
        ])
    }

    private func setupFilterTitle() {
        filterContainer.addSubview(filterTitle)
        NSLayoutConstraint.activate([
            filterTitle.topAnchor.constraint(equalTo: filterIcon.bottomAnchor),
            filterTitle.leadingAnchor.constraint(equalTo: filterContainer.leadingAnchor),
            filterTitle.trailingAnchor.constraint(equalTo: filterContainer.trailingAnchor),
            filterTitle.heightAnchor.constraint(equalToConstant: 20),
            filterTitle.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor, constant: -4)
        ])
    }

    private func setupFilterButton() {
        filterContainer.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: filterContainer.topAnchor),
            filterButton.leadingAnchor.constraint(equalTo: filterContainer.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: filterContainer.trailingAnchor),
            filterButton.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor)
        ])
    }

    //MARK: - Functions
    @objc private func shareTapped() {
        delegate?.toolbarOptionSelected(type: .share)
    }

    @objc private func saveTapped() {
        delegate?.toolbarOptionSelected(type: .save)
    }

    @objc private func filterTapped() {
        delegate?.toolbarOptionSelected(type: .filter)
    }

    func deactivateButtons() {
        saveButton.isEnabled = false
        shareButton.isEnabled = false
        filterButton.isEnabled = false
    }

    func activateButtons() {
        saveButton.isEnabled = true
        shareButton.isEnabled = true
        filterButton.isEnabled = true
    }

    func addFilterFunctionality() {
        setupFilterContainer()
        setupFilterIcon()
        setupFilterTitle()
        setupFilterButton()
        layoutIfNeeded()
    }

    func toggleFilterUI() {
        switch filterTitle.text {
        case StyleGuide.AppCopy.Toolbar.filterText:
            filterIcon.image = UIImage(named: StyleGuide.Assets.endFilterIcon)?.withRenderingMode(.alwaysOriginal)
            filterTitle.text = StyleGuide.AppCopy.Toolbar.doneText
            layoutIfNeeded()
        case StyleGuide.AppCopy.Toolbar.doneText:
            filterIcon.image = UIImage(named: StyleGuide.Assets.filteringIcon)?.withRenderingMode(.alwaysTemplate)
            filterIcon.tintColor = .white
            filterTitle.text = StyleGuide.AppCopy.Toolbar.filterText
            layoutIfNeeded()
        default:
            break
        }
    }
}

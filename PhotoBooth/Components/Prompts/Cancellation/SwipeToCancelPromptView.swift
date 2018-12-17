import UIKit

class SwipeToCancelPromptView: UIView {

    private let viewModel: SwipeToCancelPromptViewModeling

    lazy var labelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.promptText
        label.font = UIFont.semiBoldFont(size: 22)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var spacingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: SwipeToCancelPromptViewModeling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        setupViews()
    }

    private func setupViews() {
        setupLabelContainer()
        setupPromptLabel()
        setupSpacingView()
    }

    private func setupLabelContainer() {
        addSubview(labelContainer)
        NSLayoutConstraint.activate([
            labelContainer.topAnchor.constraint(equalTo: topAnchor),
            labelContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }

    private func setupPromptLabel() {
        labelContainer.addSubview(promptLabel)
        NSLayoutConstraint.activate([
            promptLabel.topAnchor.constraint(equalTo: labelContainer.topAnchor, constant: 20),
            promptLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor, constant: 10),
            promptLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor, constant: -10),
            promptLabel.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor, constant: -20)
            ])
    }

    private func setupSpacingView() {
        addSubview(spacingView)
        NSLayoutConstraint.activate([
            spacingView.topAnchor.constraint(equalTo: labelContainer.bottomAnchor),
            spacingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            spacingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            spacingView.heightAnchor.constraint(equalTo: labelContainer.heightAnchor, multiplier: 3),
            spacingView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}



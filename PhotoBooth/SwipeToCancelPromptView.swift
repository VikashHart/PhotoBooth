import UIKit

class SwipeToCancelPromptView: UIView {

    private let viewModel: SwipeToCancelPromptViewModel

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

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: SwipeToCancelPromptViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        setupPromptLabel()
    }

    private func setupPromptLabel() {
        addSubview(promptLabel)
        NSLayoutConstraint.activate([
            promptLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            promptLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            promptLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            promptLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
    }
}



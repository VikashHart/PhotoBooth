import UIKit
import Lottie

class SwipeToCancelPromptView: UIView {

    private let viewModel: SwipeToCancelPromptViewModeling

    lazy var labelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
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

    lazy var animationView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named(StyleGuide.LottieAnimations.swipeDown)
        view.loopMode = .loop
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
        configureView()
        setupViews()
    }

    private func configureView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.addBlurEffect(blurStyle: .light)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        animationView.play()
    }

    private func setupViews() {
        setupLabelContainer()
        setupPromptLabel()
        setupSpacingView()
        setupAnimationView()
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
            promptLabel.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor, constant: 0)
            ])
    }

    private func setupSpacingView() {
        addSubview(spacingView)
        NSLayoutConstraint.activate([
            spacingView.topAnchor.constraint(equalTo: labelContainer.bottomAnchor),
            spacingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            spacingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            spacingView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            spacingView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupAnimationView() {
        spacingView.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: spacingView.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: spacingView.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 250),
            animationView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}

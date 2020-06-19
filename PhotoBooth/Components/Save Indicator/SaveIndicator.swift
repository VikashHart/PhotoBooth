import UIKit
import Lottie

class SaveIndicator: UIView {

    // MARK: - Objects
    lazy var blurContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addBlurEffect(blurStyle: .light)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var animationView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named(StyleGuide.LottieAnimations.saved)
        view.loopMode = .playOnce
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    // MARK: - Setup Methods
    private func commonInit() {
        configureView()
        setupViews()
    }

    private func configureView() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    private func setupViews() {
        setupBlurContainer()
        setupAnimationView()
    }

    // MARK: - Constraints
    private func setupBlurContainer() {
        addSubview(blurContainer)
        NSLayoutConstraint.activate([
            blurContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            blurContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    private func setupAnimationView() {
        blurContainer.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: blurContainer.topAnchor, constant: 10),
            animationView.leadingAnchor.constraint(equalTo: blurContainer.leadingAnchor, constant: 10),
            animationView.trailingAnchor.constraint(equalTo: blurContainer.trailingAnchor, constant: -10),
            animationView.bottomAnchor.constraint(equalTo: blurContainer.bottomAnchor, constant: -10),
            animationView.heightAnchor.constraint(equalToConstant: 130),
            animationView.widthAnchor.constraint(equalToConstant: 130)
        ])
    }

    //MARK: - Animation methods
    func playAnimation(completion: @escaping () -> Void) {
        animationView.stop()
        animationView.play { (_) in
            completion()
        }
    }

    func stopAnimation() {
        animationView.stop()
    }
}

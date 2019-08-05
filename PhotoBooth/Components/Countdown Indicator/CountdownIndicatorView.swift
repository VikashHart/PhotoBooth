import UIKit

class CountdownIndicatorView: UIView {
    private let viewModel: CountdownIndicatorViewModeling

    private let pulseLayer = CAShapeLayer()
    private let startAngle = -CGFloat.pi / 2

    lazy var countdownLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.timerLabelText
        label.font = UIFont.boldFont(size: 23)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: CountdownIndicatorViewModeling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }

    func updateWith(timeRemaining: Seconds, animated: Bool) {
        viewModel.update(timeRemaining: timeRemaining)
        countdownLabel.text = viewModel.timerLabelText
        if animated {
            animatePulseLayer()
        }
    }

    private func commonInit() {
        backgroundColor = .white
        setupViews()
        drawBezierPath()
    }

    override func layoutSubviews() {
        pulseLayer.frame = self.bounds
        pulseLayer.position = self.layer.position
        drawBezierPath()
        super.layoutSubviews()
    }

    private func setupViews() {
        setupPulsingLayer()
        setupCenterLabel()
    }

    private func setupCenterLabel() {
        addSubview(countdownLabel)
        NSLayoutConstraint.activate([
            countdownLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countdownLabel.widthAnchor.constraint(equalToConstant: 40),
            countdownLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupPulsingLayer() {
        layer.addSublayer(pulseLayer)
        drawBezierPath()
        pulseLayer.lineCap = CAShapeLayerLineCap.round
        pulseLayer.fillColor = UIColor.photoBoothBlue.withAlphaComponent(0.8).cgColor
    }

    private func drawBezierPath() {
        pulseLayer.frame = bounds
        pulseLayer.path = {
            let bz = UIBezierPath(roundedRect: bounds,
                                  cornerRadius: min(frame.width/2, frame.height/2))
            return bz.cgPath
        }()
    }

    private func animatePulseLayer() {
        let pulsingAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulsingAnimation.toValue = 1.2
        pulsingAnimation.duration = 0.5
        pulsingAnimation.autoreverses = true
        pulsingAnimation.repeatCount = 1
        pulsingAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        pulseLayer.add(pulsingAnimation, forKey: "pulsing")
    }
}

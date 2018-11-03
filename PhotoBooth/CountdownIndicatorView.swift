import UIKit

class CountdownIndicatorView: UIView {

    private let pulseLayer = CAShapeLayer()
    private let startAngle = -CGFloat.pi / 2

    lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
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

    init() {
        super.init(frame: .zero)
        commonInit()
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
        addSubview(centerLabel)
        NSLayoutConstraint.activate([
            centerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerLabel.widthAnchor.constraint(equalToConstant: 40),
            centerLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupPulsingLayer() {
        layer.addSublayer(pulseLayer)
        drawBezierPath()
        pulseLayer.lineCap = kCALineCapRound
        pulseLayer.fillColor = UIColor.photoBoothBlue.withAlphaComponent(0.8).cgColor

        animatePulseLayer()
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
        pulsingAnimation.repeatCount = Float.infinity
        pulsingAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        pulseLayer.add(pulsingAnimation, forKey: "pulsing")
    }
}

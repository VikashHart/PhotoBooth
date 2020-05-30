import UIKit

class TripleStripeMaskLayer: CAShapeLayer {

    func drawPath() {
        let mutablePath = CGMutablePath()
        mutablePath.addPath(firstStripePath())
        mutablePath.addPath(secondStripePath())
        mutablePath.addPath(thirdStripePath())
        self.path = mutablePath
    }

    private func firstStripePath() -> CGPath {
        let points: [CGPoint] = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: frame.width * 0.1, y: 0),
            CGPoint(x: frame.width * 0.4, y: frame.height),
            CGPoint(x: frame.width * 0.3, y: frame.height)
        ]
        return path(with: points)
    }

    private func secondStripePath() -> CGPath {
        let points: [CGPoint] = [
            CGPoint(x: frame.width * 0.2, y: 0),
            CGPoint(x: frame.width * 0.4, y: 0),
            CGPoint(x: frame.width * 0.7, y: frame.height),
            CGPoint(x: frame.width * 0.5, y: frame.height)
        ]
        return path(with: points)
    }

    private func thirdStripePath() -> CGPath {
        let points: [CGPoint] = [
            CGPoint(x: frame.width * 0.6, y: 0),
            CGPoint(x: frame.width * 0.7, y: 0),
            CGPoint(x: frame.width, y: frame.height),
            CGPoint(x: frame.width * 0.9, y: frame.height)
        ]
        return path(with: points)
    }

    private func path(with corners: [CGPoint]) -> CGPath {
        let path = UIBezierPath()
        guard let first = corners.first else {
            return path.cgPath
        }
        path.move(to: first)
        for point in corners[1...] {
            path.addLine(to: point)
        }
        path.addLine(to: first)
        return path.cgPath
    }
}

extension UIView {
    func animateShimmer(withMask mask: UIView,
                        shimmerWidth: CGFloat,
                        maskColor: UIColor,
                        duration: CFTimeInterval = 0.6,
                        repeatCount: Float = 1,
                        insertionPoint: Int = 0) {
        mask.backgroundColor = maskColor
        let maskheight = mask.frame.height
        let stripeLayer = TripleStripeMaskLayer() //CAShapeLayer()
        stripeLayer.frame = CGRect(x: -shimmerWidth, y: 0, width: shimmerWidth, height: maskheight)
        mask.layer.mask = stripeLayer
        self.insertSubview(mask, at: insertionPoint)
        stripeLayer.drawPath()
        stripeLayer.fillColor = UIColor.blue.cgColor
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = stripeLayer.position
        animation.toValue = CGPoint(x: mask.frame.maxX + shimmerWidth / 2,
                                    y: mask.frame.midY)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = duration
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock {
            mask.removeFromSuperview()
        }
        stripeLayer.add(animation, forKey: "shimmer")
        CATransaction.commit()
    }
}

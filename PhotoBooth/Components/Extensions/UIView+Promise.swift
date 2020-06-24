import UIKit
import PromiseKit

extension UIView {
    static func promiseAnimation(withDuration duration: TimeInterval, animations: @escaping () -> Void) -> Guarantee<Void> {
        return Guarantee { (resolver) in
            UIView.animate(withDuration: duration, animations: animations) { (_) in
                resolver(())
            }
        }
    }
}

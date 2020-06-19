//import UIKit
//
//extension UINavigationBar {
//    func addBlurEffect() {
//        let bounds = self.navigationController.navigationBar.bounds
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//        visualEffectView.frame = bounds ?? CGRect.zero
//        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.navigationController.navigationBar.sendSubview(toBack: visualEffectView)
//
//        // Here you can add visual effects to any UIView control.
//        // Replace custom view with navigation bar in the above code to add effects to the custom view.
//    }
//    func addBlurEffect(toView view:UIView?) {
//        // Add blur view
//        guard let view = view else { return }
//
//        //This will let visualEffectView to work perfectly
//        if let navBar = view as? UINavigationBar{
//            navBar.setBackgroundImage(UIImage(), for: .default)
//            navBar.shadowImage = UIImage()
//        }
//
//        var bounds = view.bounds
//        bounds.offsetBy(dx: 0.0, dy: -20.0)
//        bounds.size.height = bounds.height + 20.0
//
//        let blurEffect = UIBlurEffect(style: .dark)
//        let visualEffectView = UIVisualEffectView(effect: blurEffect)
//
//        visualEffectView.isUserInteractionEnabled = false
//        visualEffectView.frame = bounds
//        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        view.insertSubview(visualEffectView, at: 0)
//    }
//    func installBlurEffect() {
//        isTranslucent = true
//        setBackgroundImage(UIImage(), for: .default)
//        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
//        var blurFrame = bounds
//        blurFrame.size.height += statusBarHeight
//        blurFrame.origin.y -= statusBarHeight
//        let blurView  = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        blurView.isUserInteractionEnabled = false
//        blurView.frame = blurFrame
//        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        addSubview(blurView)
//        blurView.layer.zPosition = -1
//    }
//}

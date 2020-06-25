import UIKit

typealias Seconds = Int

enum FontType: String {
    case regular = "AvenirNext-Regular"
    case medium = "AvenirNext-Medium"
    case bold = "AvenirNext-Bold"
    case semiBold = "AvenirNext-DemiBold"
}

extension UIFont {
    static func regularFont(size: CGFloat) -> UIFont {
        return UIFont.appFont(type: .regular, size: size)
    }

    static func mediumFont(size: CGFloat) -> UIFont {
        return UIFont.appFont(type: .medium, size: size)
    }

    static func boldFont(size: CGFloat) -> UIFont {
        return UIFont.appFont(type: .bold, size: size)
    }

    static func semiBoldFont(size: CGFloat) -> UIFont {
        return UIFont.appFont(type: .semiBold, size: size)
    }

    static func appFont(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}

import UIKit

// MARK: - UIColor Hex Converter
extension UIColor {
    convenience init? (hexString: String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.punctuationCharacters)
        let filteredStr = hexString.filter{"aAbBcCdDeEfF0123456789".contains($0)}

        guard hexString.count == filteredStr.count, hexString.count == 6 else {
            return nil
        }

        let positionR = hexString.index(hexString.startIndex, offsetBy: 2)
        let positionG = hexString.index(hexString.startIndex, offsetBy: 4)

        guard let r = Double("0x" + hexString[..<positionR]),
            let g = Double("0x" + hexString[positionR..<positionG]),
            let b = Double("0x" + hexString[positionG...]) else { return nil }

        self.init(red:   CGFloat(r / 255),
                  green: CGFloat(g / 255),
                  blue:  CGFloat(b / 255),
                  alpha: 1)
    }
}

// MARK: - UIColor Methods
extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0, 0, 0, 0)
    }

    // hue, saturation, brightness and alpha components from UIColor**
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return (hue, saturation, brightness, alpha)
        }
        return (0,0,0,0)
    }

    var htmlRGB: String {
        return String(format: "#%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255))
    }

    var htmlRGBA: String {
        return String(format: "#%02x%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255), Int(rgba.alpha * 255) )
    }
}

// MARK: - Created UIColors
extension UIColor {
    //Black
    static let photoBoothBlackLight = UIColor(hexString: "262933")!
    static let photoBoothBlackDark = UIColor(hexString: "1A1D21")!
    //Gray
    static let shadowGray = UIColor(hexString: "b4b4b4")!
    // Blue
    static let photoBoothBlue = UIColor(hexString: "3BAADC")!
    static let photoBoothLight = UIColor(hexString: "2BC1E4")!
    static let photoBoothMed = UIColor(hexString: "32AACD")!
    static let photoBoothDark = UIColor(hexString: "227791")!
}

// MARK: - Created cgColor Arrays
extension CGColor {
    static let blues = [UIColor.photoBoothLight.cgColor, UIColor.photoBoothBlue.cgColor, UIColor.photoBoothMed.cgColor, UIColor.photoBoothDark.cgColor]
    static let blacks = [UIColor.photoBoothBlackDark.cgColor, UIColor.photoBoothBlackLight.cgColor]
}

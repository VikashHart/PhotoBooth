import UIKit

class BackdropObject: BackdropObjectModeling {
    var image: UIImage
    var label: String

    init(image: UIImage = UIImage(), label: String = "None") {
        self.image = image
        self.label = label
    }
}

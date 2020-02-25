import UIKit

class BackdropViewModel: BackdropViewModelModeling {
    var image: UIImage

    var label: String

    init(image: UIImage = UIImage(named: "none_image") ?? UIImage(),
         label: String = "None") {
        self.image = image
        self.label = label
    }
}

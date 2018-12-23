import UIKit

protocol PreviewViewModeling {
    var image: UIImage { get }
}

class PreviewViewModel: PreviewViewModeling {

    var image: UIImage

    init(image: UIImage) {
        self.image = image
    }
}

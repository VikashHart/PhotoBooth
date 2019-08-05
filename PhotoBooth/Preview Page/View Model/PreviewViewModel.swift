import UIKit

protocol PreviewViewModeling {
    var image: UIImage { get }
}

class PreviewViewModel: PreviewViewModeling {

    let image: UIImage

    init(image: UIImage) {
        self.image = image
    }
}

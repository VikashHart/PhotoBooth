import UIKit

protocol PreviewViewModeling {
    var image: UIImage { get }
    var imageIdentifier: String { get }
}

class PreviewViewModel: PreviewViewModeling {
    let image: UIImage
    let imageIdentifier: String

    init(image: UIImage, imageIdentifier: String) {
        self.image = image
        self.imageIdentifier = imageIdentifier
    }
}

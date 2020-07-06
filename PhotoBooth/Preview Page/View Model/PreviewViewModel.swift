import UIKit

protocol PreviewViewModeling {
    var selectedImage: UIImage { get }
    var onImageChanged: (() -> Void)? { get set }
    var imageIdentifier: String { get }

    func setImage(image: UIImage)
}

class PreviewViewModel: PreviewViewModeling {
    private(set) var selectedImage: UIImage {
        didSet {
            onImageChanged?()
        }
    }

    var onImageChanged: (() -> Void)?
    let imageIdentifier: String

    init(image: UIImage,
         imageIdentifier: String){
        self.selectedImage = image
        self.imageIdentifier = imageIdentifier
    }

    func setImage(image: UIImage) {
        self.selectedImage = image
    }
}

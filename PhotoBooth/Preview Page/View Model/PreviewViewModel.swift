import UIKit

protocol PreviewViewModeling {
    var selectedImage: UIImage { get }
    var onImageChanged: (() -> Void)? { get set }

    func setImage(image: UIImage)
}

class PreviewViewModel: PreviewViewModeling {
    private(set) var selectedImage: UIImage {
        didSet {
            onImageChanged?()
        }
    }

    var onImageChanged: (() -> Void)?

    init(image: UIImage){
        self.selectedImage = image
    }

    func setImage(image: UIImage) {
        self.selectedImage = image
    }
}

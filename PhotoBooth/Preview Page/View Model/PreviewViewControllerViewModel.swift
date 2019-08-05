import UIKit

protocol PreviewViewControllerModeling {
    var previewViewModel: PreviewViewModel { get }
}

class PreviewViewControllerModel: PreviewViewControllerModeling {
    var previewViewModel: PreviewViewModel

    init(image: UIImage, imageIdentifier: String) {
        self.previewViewModel = PreviewViewModel(image: image,
                                                 imageIdentifier: imageIdentifier)
    }
}

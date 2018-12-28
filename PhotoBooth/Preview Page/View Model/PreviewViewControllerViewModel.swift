import UIKit

protocol PreviewViewControllerModeling {
    var previewViewModel: PreviewViewModel { get }
}

class PreviewViewControllerModel: PreviewViewControllerModeling {
    var previewViewModel: PreviewViewModel

    init(image: UIImage) {
        self.previewViewModel = PreviewViewModel(image: image)
    }
}

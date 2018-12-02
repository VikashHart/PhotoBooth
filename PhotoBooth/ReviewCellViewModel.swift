import UIKit

class ReviewCellViewModel: ReviewCellModeling {
    var isSelected: Bool
    var image: UIImage {
        didSet {
            updateImage()
        }
    }

    init(isSelected: Bool = false, image: UIImage) {
        self.isSelected = isSelected
        self.image = image
    }

    private func updateImage() {
        
    }
}

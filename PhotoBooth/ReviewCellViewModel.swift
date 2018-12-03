import UIKit

class ReviewCellViewModel: ReviewCellModeling {
    var isSelected: Bool {
        didSet {
            onSelectionChanged?()
        }
    }

    let image: UIImage

    var hidePhotoIcon: Bool {
        return !isSelected
    }

    var selectionAlpha: CGFloat {
        return isSelected ? 0.5 : 0
    }

    var onSelectionChanged: (() -> Void)?

    init(isSelected: Bool = false, image: UIImage) {
        self.isSelected = isSelected
        self.image = image
    }
}

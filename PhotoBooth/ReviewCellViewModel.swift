import UIKit

class ReviewCellViewModel: ReviewCellModeling {
    var isSelected: Bool

    init(isSelected: Bool = false) {
        self.isSelected = isSelected
    }
}

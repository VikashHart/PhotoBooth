import UIKit

class ReviewPageViewModel: ReviewPageViewModeling {

    private var _cellViewModel: ReviewCellViewModel
    var cellViewModel: ReviewCellModeling { return _cellViewModel }

    let cellSpacing: CGFloat
    let numberOfCells: CGFloat
    let numberOfSpaces: CGFloat
    var isSelectable: Bool

    init(cellSpacing: CGFloat = 5, numCells: CGFloat = 2, isSelectable: Bool = false, reviewCellViewModel: ReviewCellViewModel = ReviewCellViewModel(isSelected: false)) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numCells
        self.numberOfSpaces = numCells + 1
        self.isSelectable = isSelectable
        self._cellViewModel = reviewCellViewModel
    }

}


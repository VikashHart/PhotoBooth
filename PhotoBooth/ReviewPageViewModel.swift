import UIKit

class ReviewPageViewModel: ReviewPageViewModeling {

    var capturedImages: [UIImage]
    var selectedIndices = [IndexPath]()
    var selectedImages: [UIImage] {
        return selectedIndices.map({ (indexPath) in
            return capturedImages[indexPath.row]
        })
    }

    let cellSpacing: CGFloat
    let numberOfCells: CGFloat
    let numberOfSpaces: CGFloat
    var isSelectable: Bool

    var reloadIndices: (([IndexPath]) -> Void)?

    init(cellSpacing: CGFloat = 5,
         numCells: CGFloat = 2,
         isSelectable: Bool = false,
         capturedImages: [UIImage]) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numCells
        self.numberOfSpaces = numCells + 1
        self.isSelectable = isSelectable
        self.capturedImages = capturedImages
    }

    func getCellViewModel(indexPath: IndexPath) -> ReviewCellModeling {
        let viewModel = ReviewCellViewModel(isSelected: selectedIndices.contains(indexPath),
                                            image: capturedImages[indexPath.row])
        
        return viewModel
    }

    func add(index: IndexPath) {
        selectedIndices.append(index)
    }

    func remove(index: IndexPath) {
        selectedIndices = selectedIndices.filter({ (indexPath) -> Bool in
            return indexPath.row != index.row
            })
    }

    func deselectAll() {
        if selectedIndices.isEmpty == false {
            let indexes = selectedIndices
            clearSelectedItems()
            reloadIndices?(indexes)
        }
    }

    private func clearSelectedItems() {
        selectedIndices = [IndexPath]()
    }
}


import UIKit

class ReviewPageViewModel: ReviewPageViewModeling {

    var capturedImages: [UIImage]
    var selectedIndicies = [IndexPath]()
    var selectedImages = [UIImage]()

    let cellSpacing: CGFloat
    let numberOfCells: CGFloat
    let numberOfSpaces: CGFloat
    var isSelectable: Bool

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
        let viewModel = ReviewCellViewModel(image: capturedImages[indexPath.row])
        return viewModel
    }

//    func getImages(index: Int) -> [UIImage] {
//        for index in selectedIndicies {
//            if capturedImages.contains()
//        }
//    }
    func clearSelectedItems() {
        
        selectedIndicies = [IndexPath]()
        selectedImages = [UIImage]()
    }

    func scrubViewModel() {
        capturedImages = [UIImage]()
        selectedIndicies = [IndexPath]()
        selectedImages = [UIImage]()
    }
}


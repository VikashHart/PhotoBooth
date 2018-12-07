import UIKit

protocol ReviewViewControllerModeling {
    var reviewViewModel: ReviewPageViewModeling { get }

    var capturedImages: [UIImage] { get }
    var selectedIndices: [IndexPath] { get set }
    var selectedImages: [UIImage] { get }
    var reloadIndices: (([IndexPath]) -> Void)? { get set }

    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var isSelectable: Bool { get set }

    var onShareToggled: ((Bool) -> Void)? { get set }

    func getCellViewModel(indexPath: IndexPath) -> ReviewCellModeling
    func add(index: IndexPath)
    func remove(index: IndexPath)
    func deselectAll()
    func selectPressed()
    func donePressed()
}

import UIKit

protocol ReviewPageViewModeling {
    var capturedImages: [UIImage] { get }
    var selectedIndicies: [IndexPath] { get set }
    var selectedImages: [UIImage] { get set }

    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var isSelectable: Bool { get set }

    func getCellViewModel(indexPath: IndexPath) -> ReviewCellModeling
    func clearSelectedItems()
    func scrubViewModel()
}

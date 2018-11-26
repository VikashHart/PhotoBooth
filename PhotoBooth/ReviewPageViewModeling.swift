import UIKit

protocol ReviewPageViewModeling {
    var cellViewModel: ReviewCellModeling { get }

    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var isSelectable: Bool { get set }
}

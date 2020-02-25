import UIKit

protocol BackdropViewControllerViewModeling {
    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var selectedIndex: [IndexPath] { get set }
    var backdropImages: [BackdropObject] { get }
}

class BackdropViewControllerViewModel: BackdropViewControllerViewModeling {
    var cellSpacing: CGFloat
    var numberOfCells: CGFloat
    var numberOfSpaces: CGFloat
    var selectedIndex = [IndexPath]()
    var backdropImages: [BackdropObject]

    init(cellSpacing: CGFloat = 16,
         numberOfCells: CGFloat = 1,
         backdropImages: BackdropImages = BackdropImages()) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1
        self.backdropImages = backdropImages.backdropImages
    }
}

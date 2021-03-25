import UIKit

protocol FilterCellViewModeling {
    var imageObject: UIImage { get }
    var filterName: String { get }
    var isSelected: Bool { get }
    var isSpinnerActive: Bool { get }
    var isSelectedChanged: (() -> Void)? { get set }
    var imageDidUpdate: (() -> Void)? { get set }

    func setCellSelection(state: Bool)
    func getFilteredImage()
}

class FilterCellViewModel: FilterCellViewModeling {
    private(set) var isSelected: Bool {
        didSet {
            isSelectedChanged?()
        }
    }
    var isSpinnerActive: Bool
    var isSelectedChanged: (() -> Void)?
    var imageDidUpdate: (() -> Void)?
    var imageObject: UIImage
    var filterName: String
    private var filter: FilterObject

    init(image: UIImage,
         isSelected: Bool = false,
         isSpinnerActive: Bool = true,
         filter: FilterObject) {
        self.imageObject = image
        self.filterName = filter.name
        self.isSelected = isSelected
        self.isSpinnerActive = isSpinnerActive
        self.filter = filter
    }

    func setCellSelection(state: Bool) {
        isSelected = state
    }

    func getFilteredImage() {
        imageObject.applyFilter(filter: filter,
                                completion: { [weak self] image in
                                    self?.imageObject = image
                                    self?.isSpinnerActive = false
                                    self?.imageDidUpdate?()
        })
    }
}

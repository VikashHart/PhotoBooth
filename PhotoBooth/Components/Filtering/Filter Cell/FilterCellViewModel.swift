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
    var imageObject: UIImage {
        didSet {
            isSpinnerActive = false
            imageDidUpdate?()
        }
    }
    var filterName: String

    private var filterDesignation: String

    init(image: UIImage,
         isSelected: Bool = false,
         isSpinnerActive: Bool = true,
         filterDesignation: String,
         filterName: String) {
        self.imageObject = image
        self.filterName = filterName
        self.isSelected = isSelected
        self.isSpinnerActive = isSpinnerActive
        self.filterDesignation = filterDesignation
    }

    func setCellSelection(state: Bool) {
        isSelected = state
    }

    func getFilteredImage() {
        imageObject.applyFilter(filter: filterDesignation,
                                completion: { [weak self] image in
                                    self?.imageObject = image
        })
    }
}

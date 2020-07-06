import UIKit

protocol PreviewCellModeling {
    var isSelected: Bool { get }
    var cellImage: UIImage { get }
    var isSelectedChanged: (() -> Void)? { get set }

    func setCellSelection(state: Bool)
}

class PreviewCellViewModel: PreviewCellModeling {
    private(set) var isSelected: Bool {
        didSet {
            isSelectedChanged?()
        }
    }

    var cellImage: UIImage
    var isSelectedChanged: (() -> Void)?

    init(isSelected: Bool = false,
         cellImage: UIImage) {
        self.isSelected = isSelected
        self.cellImage = cellImage
    }

    func setCellSelection(state: Bool) {
        isSelected = state
    }
}

import UIKit

class ReviewCellViewModel: ReviewCellModeling {
    var isSelected: Bool {
        didSet {
            onSelectionChanged?()
        }
    }

    let image: UIImage

    let showSelectionStatus: Bool

    var selectionAlpha: CGFloat {
        return isSelected ? 0.33 : 0
    }

    var onSelectionChanged: (() -> Void)?
    var onSelectToggled: (() -> Void)?

    init(isSelected: Bool = false,
         showSelectionStatus: Bool = false,
         image: UIImage) {
        self.isSelected = isSelected
        self.showSelectionStatus = showSelectionStatus
        self.image = image
    }

    func getSelectionImage() -> UIImage? {
        guard showSelectionStatus == true else { return nil }
        var image: UIImage?
        if isSelected == true {
            let icon = UIImage(named: StyleGuide.Assets.selectionModeOn)
            image = icon
        } else if isSelected == false {
            let icon = UIImage(named: StyleGuide.Assets.unselected)
            image = icon
        }
        return image
    }
}

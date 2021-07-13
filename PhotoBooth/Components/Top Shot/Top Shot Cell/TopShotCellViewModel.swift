import UIKit

protocol TopShotCellViewModeling {
    var images: [UIImage] { get }
    var isSpinnerActive: Bool { get set }
    var topShotImage: UIImage { get }
    var isSelected: Bool { get set }
    var showSelectionStatus: Bool { get }
    var selectionAlpha: CGFloat { get }
    var onSelectionChanged: (() -> Void)? { get set }
    var onSelectToggled: (() -> Void)? { get set }
    var imageDidUpdate: (() -> Void)? { get set }
    func set(selection state: Bool)
    func getSelectionImage() -> UIImage?
    func getTopShot()
}

class TopShotCellViewModel: TopShotCellViewModeling {
    var isSpinnerActive: Bool
    var images: [UIImage]
    private(set) var topShotImage: UIImage

    var isSelected: Bool {
        didSet {
            onSelectionChanged?()
        }
    }

    let showSelectionStatus: Bool

    var selectionAlpha: CGFloat {
        return isSelected ? 0.33 : 0
    }

    var onSelectionChanged: (() -> Void)?
    var onSelectToggled: (() -> Void)?
    var imageDidUpdate: (() -> Void)?

    private let imageQualityHandler: ImageQualityDetection

    init(images: [UIImage],
         topShotImage: UIImage = UIImage(),
         isSelected: Bool = false,
         showSelectionStatus: Bool = false,
         isSpinnerActive: Bool = true,
         imageQualityHandler: ImageQualityDetection = ImageQualityDetection()) {
        self.images = images
        self.topShotImage = topShotImage
        self.isSelected = isSelected
        self.showSelectionStatus = showSelectionStatus
        self.isSpinnerActive = isSpinnerActive
        self.imageQualityHandler = imageQualityHandler
    }

    func set(selection state: Bool) {
        isSelected = state
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

    func getTopShot() {
        imageQualityHandler.analyzeImages(images: images,
                                                        completion: { [weak self] image in
                                                            self?.topShotImage = image
                                                            self?.isSpinnerActive = false
                                                            self?.imageDidUpdate?()
                                                        })
    }
}

import UIKit

protocol ReviewCellModeling {
    var isSelected: Bool { get set }
    var image: UIImage { get }
    var hidePhotoIcon: Bool { get }
    var selectionAlpha: CGFloat { get }
    var onSelectionChanged: (() -> Void)? { get set }
}

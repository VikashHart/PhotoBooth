import UIKit

protocol ReviewCellModeling {
    var isSelected: Bool { get set }
    var image: UIImage { get }
    var showSelectionStatus: Bool { get }
    var selectionAlpha: CGFloat { get }
    var onSelectionChanged: (() -> Void)? { get set }
    var onSelectToggled: (() -> Void)? { get set }
    func getSelectionImage() -> UIImage?
}

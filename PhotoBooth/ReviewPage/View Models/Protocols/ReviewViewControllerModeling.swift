import UIKit
import PromiseKit

protocol ReviewViewControllerModeling {
    var reviewViewModel: ReviewPageViewModeling { get }

    var permissionStatus: AuthorizationStatus { get }

    var data: PhotoShootData { get }
    var selectedIndices: [IndexPath] { get set }
    var selectedImages: [UIImage] { get }
    var reloadIndices: (([IndexPath]) -> Void)? { get set }

    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var isSelectable: Bool { get set }

    var onSelectToggled: (() -> Void)? { get set }

    func getCellViewModel(indexPath: IndexPath) -> ReviewCellModeling
    func add(index: IndexPath)
    func remove(index: IndexPath)
    func deselectAll()
    func selectPressed()
    func donePressed()
    func requestPhotosPermission()
    func postShareCancelled()
    func postShareCompleted(activityType: UIActivity.ActivityType)
    func saveImages() -> Promise<Void>
}

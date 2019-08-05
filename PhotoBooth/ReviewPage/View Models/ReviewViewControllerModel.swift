import UIKit
import RxSwift

class ReviewViewControllerModel: ReviewViewControllerModeling {
    lazy var reviewViewModel: ReviewPageViewModeling = {
        return ReviewPageViewModel(selectionCountObservable:
            selectedIndicesSubject
                .asObservable()
                .debug()
                .map({$0.count})
        )
    }()

    private var capturedImages: [UIImage] {
        return data.images
    }
    let data: PhotoShootData
    var selectedIndices: [IndexPath] {
        didSet {
            selectedIndicesSubject.onNext(selectedIndices)
        }
    }
    var selectedImages: [UIImage] {
        return selectedIndices.map({ (indexPath) in
            return capturedImages[indexPath.row]
        })
    }

    private lazy var selectedIndicesSubject: BehaviorSubject<[IndexPath]> = {
        return BehaviorSubject(value: selectedIndices)
    }()

    let cellSpacing: CGFloat
    let numberOfCells: CGFloat
    let numberOfSpaces: CGFloat
    var isSelectable: Bool

    var reloadIndices: (([IndexPath]) -> Void)?
    var onShareToggled: ((Bool) -> Void)?

    init(selectedIndices: [IndexPath] = [IndexPath](),
         cellSpacing: CGFloat = 5,
         numCells: CGFloat = 2,
         isSelectable: Bool = false,
         data: PhotoShootData) {
        self.selectedIndices = selectedIndices
        self.cellSpacing = cellSpacing
        self.numberOfCells = numCells
        self.numberOfSpaces = numCells + 1
        self.isSelectable = isSelectable
        self.data = data
    }

    func getCellViewModel(indexPath: IndexPath) -> ReviewCellModeling {
        let viewModel = ReviewCellViewModel(isSelected: selectedIndices.contains(indexPath),
                                            image: capturedImages[indexPath.row])
        return viewModel
    }

    func add(index: IndexPath) {
        selectedIndices.append(index)
    }

    func remove(index: IndexPath) {
        selectedIndices = selectedIndices.filter({ (indexPath) -> Bool in
            return indexPath.row != index.row
            })
    }

    func deselectAll() {
        if selectedIndices.isEmpty == false {
            let indexes = selectedIndices
            clearSelectedItems()
            reloadIndices?(indexes)
        }
    }

    func selectPressed() {
        isSelectable = true
        reviewViewModel.isSelectHidden = true
    }

    func donePressed() {
        isSelectable = false
        reviewViewModel.isSelectHidden = false
        deselectAll()
    }

    func postShareCancelled() {
        let parameters = data.parameters
        Analytics.logEvent("share_cancelled", parameters: parameters)
    }

    func postShareCompleted(activityType: UIActivity.ActivityType) {
        let imageOrientations = selectedImages.map { image in
            return image.orientation.description
        }
        let parameters = ["share_activity" : activityType,
                          "selected_image_count" : selectedIndices.count,
                          "image_orientations": imageOrientations] + data.parameters
        Analytics.logEvent("share_completed", parameters: parameters)
    }

    private func clearSelectedItems() {
        selectedIndices = [IndexPath]()
    }
}

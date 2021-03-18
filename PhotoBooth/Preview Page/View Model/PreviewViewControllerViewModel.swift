import UIKit
import PromiseKit

protocol PreviewViewControllerModeling {
    var previewViewModel: PreviewViewModel { get }
    var images: [UIImage] { get }
    var selectedImage: UIImage { get set }
    var selectedIndex: IndexPath { get set }
    var isOverlayVisible: Bool { get set }
    var permissionStatus: AuthorizationStatus { get }

    var toolbarMode: ToolbarEditMode { get set }
    var selectedFilterIndex: IndexPath? { get set }
    var filterViewModels: [IndexPath : FilterCellViewModeling] { get set }

    var cellSpacing: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var numberOfCells: CGFloat { get }

    func getCellViewModel(indexPath: IndexPath) -> PreviewCellModeling
    func getFilterCellViewModel(indexPath: IndexPath) -> FilterCellViewModeling
    func setToolbarMode()
    func requestPhotosPermission()
    func postShareCancelled()
    func postShareCompleted(activityType: UIActivity.ActivityType)
    func postSaveCompleted()
    func postSaveFailed()
    func saveImage() -> Promise<Void>
    func setSelectedImageAndIndex(indexPath: IndexPath)
}

class PreviewViewControllerModel: PreviewViewControllerModeling {
    //MARK: - Public Properties

    var previewViewModel: PreviewViewModel
    var images: [UIImage]
    var selectedImage: UIImage
    var selectedIndex: IndexPath
    var isOverlayVisible: Bool
    var permissionStatus: AuthorizationStatus {
        return photoAccessLevel
    }

    var toolbarMode: ToolbarEditMode
    var selectedFilterIndex: IndexPath?
    var filterViewModels: [IndexPath : FilterCellViewModeling] = [:]

    let cellSpacing: CGFloat
    let numberOfSpaces: CGFloat
    let numberOfCells: CGFloat

    //MARK: - Private Properties

    private let data: PhotoShootData

    private lazy var photoAccessLevel: AuthorizationStatus = {
        return getPermissionStatus()
    }()

    private let photoPermissionsProvider: PhotosAccess

    //MARK: - Initializer

    init(data: PhotoShootData,
         selectedIndex: IndexPath,
         toolbarMode: ToolbarEditMode = .standby,
         cellSpacing: CGFloat = StyleGuide.CollectionView.PreviewPage.cellSpacing,
         numCells: CGFloat = StyleGuide.CollectionView.PreviewPage.numberOfCells,
         isOverlayVisible: Bool = true,
         photoPermissionsProvider: PhotosAccess = PhotosPermissionsProvider()) {
        self.images = data.images
        self.selectedImage = data.images[selectedIndex.row]
        self.toolbarMode = toolbarMode
        self.previewViewModel = PreviewViewModel(image: images[selectedIndex.row])
        self.selectedIndex = selectedIndex
        self.isOverlayVisible = isOverlayVisible
        self.cellSpacing = cellSpacing
        self.numberOfCells = numCells
        self.numberOfSpaces = numberOfCells + 1
        self.data = data
        self.photoPermissionsProvider = photoPermissionsProvider
    }

    //MARK: - Public Functions

    func getCellViewModel(indexPath: IndexPath) -> PreviewCellModeling {
        let viewModel = PreviewCellViewModel(isSelected: selectedIndex == indexPath,
                                             cellImage: images[indexPath.row])
        return viewModel
    }

    func getFilterCellViewModel(indexPath: IndexPath) -> FilterCellViewModeling {
        let filter = Filtering.shared.filters[indexPath.row]
        let image = selectedImage
        let viewModel = FilterCellViewModel(image: image,
                                            isSelected: selectedFilterIndex == indexPath,
                                            filterDesignation: filter.designation,
                                            filterName: filter.name)

        filterViewModels[indexPath] = viewModel
        return  viewModel
    }

    func setToolbarMode() {
        switch toolbarMode {
        case .standby:
            toolbarMode = .filtering
            selectedFilterIndex = IndexPath(row: 0, section: 0)
            postFilteringBegan()
        case .filtering:
            toolbarMode = .standby
            selectedFilterIndex = IndexPath(row: 0, section: 0)
            filterViewModels = [:]
            setSelectedImageAndIndex(indexPath: selectedIndex)
            postFilteringEnded()
        }
    }

    func requestPhotosPermission() {
        requstPermission()
    }

    func postShareCancelled() {
        let parameters = ["vc_identifier" : ViewControllerIdentifier.preview.rawValue] + data.parameters
        Analytics.logEvent("share_cancelled", parameters: parameters)
    }

    func postShareCompleted(activityType: UIActivity.ActivityType) {
        let imageOrientation = selectedImage.orientation.description
        let parameters = ["vc_identifier" : ViewControllerIdentifier.preview.rawValue,
                          "share_activity" : activityType,
                          "image_orientations": imageOrientation] + data.parameters
        Analytics.logEvent("share_completed", parameters: parameters)
    }

    func postSaveCompleted() {
        switch toolbarMode {
        case .standby:
            let parameters = ["vc_identifier" : ViewControllerIdentifier.preview.rawValue]
            Analytics.logEvent("save_completed", parameters: parameters)
        case .filtering:
            guard let index = selectedFilterIndex?.row else { return }
            let parameters = ["vc_identifier" : ViewControllerIdentifier.preview.rawValue,
                              "filter" : Filtering.shared.filters[index].name]
            Analytics.logEvent("save_completed", parameters: parameters)
        }
    }

    func postSaveFailed() {
        let parameters = ["vc_identifier" : ViewControllerIdentifier.preview.rawValue]
        Analytics.logEvent("save_failed", parameters: parameters)
    }

    func postFilteringBegan() {
        let parameters = ["vc_identifier" : ViewControllerIdentifier.preview.rawValue]
        Analytics.logEvent("filtering_began", parameters: parameters)
    }

    func postFilteringEnded() {
        let parameters = ["vc_identifier" : ViewControllerIdentifier.preview.rawValue]
        Analytics.logEvent("filtering_ended", parameters: parameters)
    }

    func saveImage() -> Promise<Void> {
        let saveTask = PhotosAlbumSaveTask()
        let taskPromise = saveTask.saveImage(image: selectedImage)

        return when(fulfilled: taskPromise)
    }

    func setSelectedImageAndIndex(indexPath: IndexPath) {
        self.selectedImage = images[indexPath.row]
        self.selectedIndex = indexPath
        self.previewViewModel.setImage(image: images[indexPath.row])
    }

    func setSelectedFilterImageAndFilterIndex(indexPath: IndexPath) {
        if let currentlySelectedIndexPath = self.selectedFilterIndex {
            filterViewModels[currentlySelectedIndexPath]?.setCellSelection(state: false)
        }

        guard let image = filterViewModels[indexPath]?.imageObject else { return }
        self.selectedImage = image
        self.selectedFilterIndex = indexPath
        self.previewViewModel.setImage(image: image)

        filterViewModels[indexPath]?.setCellSelection(state: true)
    }

    //MARK: - Private Functions

    private func postIntialSavePermissions(status: String) {
        let parameters = ["vc_identifier" : ViewControllerIdentifier.preview,
                          "permission_status" : status] as [String : Any]
        Analytics.logEvent("initial_photo_library_permission_selection", parameters: parameters)
    }

    private func requstPermission() {
        photoPermissionsProvider.requestPhotoLibraryPermission { (status) in
            self.photoAccessLevel = status
            switch status {
            case .authorized:
                let status = "authorized"
                self.postIntialSavePermissions(status: status)
            case .denied:
                let status = "denied"
                self.postIntialSavePermissions(status: status)
            default:
                break
            }
        }
    }

    private func getPermissionStatus() -> AuthorizationStatus {
        var accessLevel: AuthorizationStatus?
        photoPermissionsProvider.getPhotoLibraryPermission { (status) in
            switch status {
            case .authorized:
                accessLevel = AuthorizationStatus.authorized
            case .denied:
                accessLevel = AuthorizationStatus.denied
            case .undetermined:
                accessLevel = AuthorizationStatus.undetermined
            }
        }
        guard let status = accessLevel else { return .denied }
        return status
    }
}

import UIKit
//import Motion
import Photos
import PromiseKit

class ReviewViewController: UIViewController {

    //MARK: - View model
    private var viewModel: ReviewViewControllerModeling

    //MARK: - UI objects
    lazy var reviewView: ReviewPageView = {
        let view = ReviewPageView(viewModel: viewModel.reviewViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupReviewView()
        configureCollectionViews()
        self.reviewView.toolbarView.delegate = self
        self.reviewView.cancelButton.addTarget(self,
                                               action: #selector(cancelSelected),
                                               for: .touchUpInside)
        self.reviewView.selectButton.addTarget(self,
                                               action: #selector(selectSelected),
                                               for: .touchUpInside)
        self.reviewView.doneButton.addTarget(self,
                                             action: #selector(doneSelected),
                                             for: .touchUpInside)
//        self.isMotionEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }

    //MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(data: PhotoShootData) {
        self.viewModel = ReviewViewControllerModel(data: data)
        super.init(nibName: nil, bundle: nil)
        self.viewModel.reloadIndices = { [weak self] indices in
            self?.reloadCells(indices: indices)
        }
    }

    private func bindUI() {
        viewModel.onSelectToggled = { [weak self] in
            UIView.animate(withDuration: 0.1) {
                self?.reviewView.collectionView.performBatchUpdates({
                    if let indexPath = self?.reviewView.collectionView.indexPathsForVisibleItems {
                        self?.reloadCells(indices: indexPath)
                    }
                })
            }
        }
    }

    //MARK: - Toolbar methods
    private func openShareMenu() {
        let activityVC = UIActivityViewController(activityItems: viewModel.selectedImages, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                self.viewModel.postShareCancelled()
                return
            }
            // User completed activity
            guard let shareActivity = activityType else { return }
            self.viewModel.postShareCompleted(activityType: shareActivity)
        }
        self.present(activityVC, animated: true, completion: nil)
    }

    private func saveImages() {
        switch self.viewModel.permissionStatus {
        case .authorized:
            self.reviewView.deactivateToolbar()
            viewModel.saveImages()
                .then(self.reviewView.showSaveIndicator)
                .done( { _ in
                    self.viewModel.postSaveCompleted()})
                .ensure {
                    self.reviewView.activateToolbar()
            }
            .catch { [weak self] (error) in
                self?.viewModel.postSaveFailed()
                let ac = UIAlertController.makeImageSaveFailureAlert(error: error)
                self?.present(ac, animated: true)
            }
        case .denied:
            let ac = UIAlertController.makeMissingPhotosAccessAlert()
            self.present(ac, animated: true)
        case .undetermined:
            self.viewModel.requestPhotosPermission()
        }
    }

    //MARK: - @objc Methods
    @objc func cancelSelected() {
        dismiss(animated: true, completion: nil)
    }

    @objc func selectSelected() {
        viewModel.selectPressed()
        viewModel.postSelectPressed()
    }

    @objc func doneSelected() {
        viewModel.donePressed()
        updateFooter()
    }

    //MARK: - Reload cells
    private func reloadCells(indices: [IndexPath]) {
        reviewView.collectionView.reloadItems(at: indices)
    }

    //MARK: - Configure Collection Views
    private func configureCollectionViews() {
        reviewView.collectionView.delegate = self
        reviewView.collectionView.dataSource = self
    }

    //MARK: - Configure Constraints
    private func setupReviewView() {
        view.addSubview(reviewView)
        NSLayoutConstraint.activate([
            reviewView.topAnchor.constraint(equalTo: view.topAnchor),
            reviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reviewView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func updateFooter() {
        switch viewModel.selectedIndices.count {
        case 0: reviewView.showToolbar(false)
        case 1: reviewView.showToolbar(true)
        default: break
        }
    }
}

//MARK: - Toolbar delegate
extension ReviewViewController: ToolbarDelegate {
    func toolbarOptionSelected(type: ToolbarOptionType) {
        switch type {
        case .share:
            openShareMenu()
        case .save:
            saveImages()
        }
    }
}

//MARK: - Collectionview delegate
extension ReviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.reviewView.collectionView.cellForItem(at: indexPath) as! ReviewCell

        if self.viewModel.isSelectable == true {
            cell.viewModel.isSelected.toggle()
            cell.viewModel.isSelected ? viewModel.add(index: indexPath) : viewModel.remove(index: indexPath)
            updateFooter()
        } else {
            let previewVC = PreviewViewController(data: viewModel.data,
                                                  selectedIndex: indexPath
//                                                  imageIdentifier: indexPath.description
            )
            previewVC.modalPresentationStyle = .fullScreen
            present(previewVC, animated: true, completion: nil)
        }
    }
}

//MARK: - Collectionview data source
extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.data.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = reviewView.collectionView.dequeueReusableCell(
            withReuseIdentifier: StyleGuide.CollectionView.ReviewPage.cellId,
            for: indexPath) as? ReviewCell else
        { return UICollectionViewCell() }
        let viewModel = self.viewModel.getCellViewModel(indexPath: indexPath)
        cell.viewModel = viewModel
//        cell.photoImageView.motionIdentifier = indexPath.description

        return cell
    }
}

//MARK: - Collectionview flow layout
extension ReviewViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - (self.viewModel.cellSpacing * self.viewModel.numberOfSpaces)) / self.viewModel.numberOfCells
        let height = width * StyleGuide.CollectionView.ReviewPage.heightMultiplier

        return CGSize(width: width , height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.viewModel.cellSpacing, left: self.viewModel.cellSpacing, bottom: self.viewModel.cellSpacing, right: self.viewModel.cellSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.cellSpacing
    }
}

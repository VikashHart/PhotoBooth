import UIKit
import PromiseKit

class PreviewViewController: UIViewController {

    private let viewModel: PreviewViewControllerModel

    lazy var previewView: PreviewView = {
        let view = PreviewView(viewModel: viewModel.previewViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.allButUpsideDown)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        scrollToActiveCell()
        viewWillLayoutSubviews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(previewView.bounds.size)
        updateConstraintsForSize(previewView.bounds.size)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        viewWillLayoutSubviews()
    }

    //MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(data: PhotoShootData,
         selectedIndex: IndexPath) {
        self.viewModel = PreviewViewControllerModel(data: data,
                                                    selectedIndex: selectedIndex)
        super.init(nibName: nil, bundle: nil)
    }

    //MARK: - Toolbar methods
    private func openShareMenu() {
        let activityVC = UIActivityViewController(activityItems: [viewModel.selectedImage], applicationActivities: nil)
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
            self.previewView.deactivateToolbar()
            viewModel.saveImage()
                .then(self.previewView.showSaveIndicator)
                .done( { _ in
                self.viewModel.postSaveCompleted()})
                .ensure {
                    self.previewView.activateToolbar()
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

    //MARK: - @objc methods
    @objc private func backSelected() {
        dismiss(animated: true, completion: nil)
    }

    @objc func handleSingleTap() {
        switch viewModel.isOverlayVisible {
        case true:
            previewView.showOverlay(false)
            viewModel.isOverlayVisible = false
        case false:
            previewView.showOverlay(true)
            viewModel.isOverlayVisible = true
        }
    }

    @objc func handleDoubleTap() {
        if previewView.imageScrollView.zoomScale < 1 {
            previewView.imageScrollView.zoomScale = 1
        } else {
            updateMinZoomScaleForSize(previewView.bounds.size)
        }
    }

    //MARK: - Button
    private func setupButtons() {
        previewView.backButton.addTarget(self,
        action: #selector(backSelected),
        for: .touchUpInside)
    }

    //MARK: - Gestures
    private func configureGestures() {
        // Single Tap
        let singleTap: UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTap.numberOfTapsRequired = 1
        previewView.imageScrollView.addGestureRecognizer(singleTap)

        // Double Tap
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        previewView.imageScrollView.addGestureRecognizer(doubleTap)

        singleTap.require(toFail: doubleTap)
        singleTap.delaysTouchesBegan = true
        doubleTap.delaysTouchesBegan = true
    }

    //MARK: - CollectionView methods
    private func scrollToActiveCell() {
        previewView.collectionView.scrollToItem(at: viewModel.selectedIndex, at: .centeredHorizontally, animated: true)
    }

    //MARK: - Configuration methods
    private func configureView() {
        setupPreviewView()
        configureCollectionView()
        configureToolbar()
        configureScrollView()
        configureGestures()
        setupButtons()
    }

    private func configureCollectionView() {
        previewView.collectionView.delegate = self
        previewView.collectionView.dataSource = self
    }

    private func configureScrollView() {
        previewView.imageScrollView.delegate = self
    }

    private func configureToolbar() {
        previewView.toolbarView.delegate = self
    }

    //MARK: - Constraints
    private func setupPreviewView() {
        view.addSubview(previewView)
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            previewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

//MARK: - ScrollView methods
extension PreviewViewController {
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / previewView.imageView.bounds.width
        let heightScale = size.height / previewView.imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        previewView.imageScrollView.minimumZoomScale = minScale
        previewView.imageScrollView.zoomScale = minScale
        
    }
}

//MARK: - ScrollView delegate
extension PreviewViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return previewView.imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(previewView.bounds.size)
    }

    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - previewView.imageView.frame.height) / 2)
        let xOffset = max(0, (size.width - previewView.imageView.frame.width) / 2)

        previewView.updateImageViewXYValues(x: xOffset, y: yOffset)

        view.layoutIfNeeded()
    }
}

//MARK: - Toolbar delegate
extension PreviewViewController: ToolbarDelegate {
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
extension PreviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath != viewModel.selectedIndex else { return }

        let lastSelected = viewModel.selectedIndex
        viewModel.setSelectedImageAndIndex(indexPath: indexPath)

        if let cell = self.previewView.collectionView.cellForItem(at: lastSelected) as? PreviewCell {
            let cellViewModel = viewModel.getCellViewModel(indexPath: lastSelected)
            cell.viewModel = cellViewModel
        }

        if let cell = self.previewView.collectionView.cellForItem(at: indexPath) as? PreviewCell {
            let cellViewModel = viewModel.getCellViewModel(indexPath: indexPath)
            cell.viewModel = cellViewModel
            updateMinZoomScaleForSize(previewView.bounds.size)
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

//MARK: - Collectionview data source
extension PreviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = previewView.collectionView.dequeueReusableCell(
            withReuseIdentifier: StyleGuide.CollectionView.PreviewPage.cellId,
            for: indexPath) as? PreviewCell else
        { return UICollectionViewCell() }

        let viewModel = self.viewModel.getCellViewModel(indexPath: indexPath)
        cell.viewModel = viewModel

        return cell
    }
}

//MARK: - Collectionview flow layout
extension PreviewViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let containerHeight = previewView.collectionViewContainer.bounds.height
        let height = (containerHeight - (self.viewModel.cellSpacing * self.viewModel.numberOfSpaces)) / self.viewModel.numberOfCells
        let width = height

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

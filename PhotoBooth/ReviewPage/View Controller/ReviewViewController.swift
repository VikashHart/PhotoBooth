import UIKit

class ReviewViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    private var viewModel: ReviewViewControllerModeling

    lazy var reviewView: ReviewPageView = {
        let view = ReviewPageView(viewModel: viewModel.reviewViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupReviewView()
        self.reviewView.collectionView.delegate = self
        self.reviewView.collectionView.dataSource = self
        self.reviewView.cancelButton.addTarget(self,
                                               action: #selector(cancelSelected),
                                               for: .touchUpInside)
        self.reviewView.selectButton.addTarget(self,
                                               action: #selector(selectSelected),
                                               for: .touchUpInside)
        self.reviewView.doneButton.addTarget(self,
                                             action: #selector(doneSelected),
                                             for: .touchUpInside)
        self.reviewView.shareButton.addTarget(self,
                                              action: #selector(shareSelected),
                                              for: .touchUpInside)
    }

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }

    func openShareMenu() {
        let activityVC = UIActivityViewController(activityItems: viewModel.selectedImages, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
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

    @objc func cancelSelected() {
        coordinator?.dismiss()
    }

    @objc func selectSelected() {
        viewModel.selectPressed()
    }

    @objc func doneSelected() {
        viewModel.donePressed()
    }

    @objc func shareSelected() {
        openShareMenu()
    }

    private func reloadCells(indices: [IndexPath]) {
        reviewView.collectionView.reloadItems(at: indices)
    }

    private func setupReviewView() {
        view.addSubview(reviewView)
        NSLayoutConstraint.activate([
            reviewView.topAnchor.constraint(equalTo: view.topAnchor),
            reviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reviewView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ReviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = self.reviewView.collectionView.cellForItem(at: indexPath) as! ReviewCell

        if self.viewModel.isSelectable == true {
            cell.viewModel.isSelected.toggle()
            cell.viewModel.isSelected ? viewModel.add(index: indexPath) : viewModel.remove(index: indexPath)
        } else {
            coordinator?.presentPreviewVC(image: cell.viewModel.image)
        }
    }
}

extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.data.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = reviewView.collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as? ReviewCell else { return UICollectionViewCell() }
        cell.viewModel = self.viewModel.getCellViewModel(indexPath: indexPath)
        cell.photoImageView.image = cell.viewModel.image
        return cell
    }
}

extension ReviewViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let width = (screenWidth - (self.viewModel.cellSpacing * self.viewModel.numberOfSpaces)) / self.viewModel.numberOfCells
        let height = (screenHeight / screenWidth) * width
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

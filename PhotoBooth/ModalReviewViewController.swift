import UIKit

class ModalReviewViewController: UIViewController {

    private let capturedImages: [UIImage]

    private var viewModel: ReviewPageViewModeling = ReviewPageViewModel()

    lazy var reviewView: ReviewPageView = {
        let view = ReviewPageView()
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

    init(capturedImages: [UIImage]) {
        self.capturedImages = capturedImages
        super.init(nibName: nil, bundle: nil)
    }

    @objc func cancelSelected() {
        dismiss(animated: true, completion: nil)
    }

    @objc func selectSelected() {
            self.viewModel.isSelectable = true
            self.reviewView.selectButton.isHidden = true
            self.reviewView.cancelButton.isHidden = true
            self.reviewView.doneButton.isHidden = false
            self.reviewView.shareButton.isEnabled = true
            self.reviewView.shareButton.tintColor = UIColor.photoBoothBlue
    }

    @objc func doneSelected() {
        self.viewModel.isSelectable = false
        self.reviewView.selectButton.isHidden = false
        self.reviewView.cancelButton.isHidden = false
        self.reviewView.doneButton.isHidden = true
        self.reviewView.shareButton.isEnabled = false
        self.reviewView.shareButton.tintColor = UIColor.lightGray
    }

    @objc func shareSelected() {

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

extension ModalReviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = self.reviewView.collectionView.cellForItem(at: indexPath) as! ReviewCell

        if self.viewModel.isSelectable == true {
            if cell.viewModel?.isSelected == true {
                cell.selectedUIView.alpha = 0.5
                cell.selectedPhotoIcon.isHidden = false
            } else {
                cell.selectedUIView.alpha = 0
                cell.selectedPhotoIcon.isHidden = true
            }
        } else {
            cell.selectedUIView.alpha = 0
            cell.selectedPhotoIcon.isHidden = true
        }
    }
}

extension ModalReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.capturedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = reviewView.collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as? ReviewCell else { return UICollectionViewCell() }
        let image = capturedImages[indexPath.row]
        cell.photoImageView.image = image
        return cell
    }
}

extension ModalReviewViewController: UICollectionViewDelegateFlowLayout {

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

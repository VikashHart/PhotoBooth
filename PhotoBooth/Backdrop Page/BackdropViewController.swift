import UIKit

class BackdropViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    let viewModel: BackdropViewControllerViewModel = BackdropViewControllerViewModel()
    let backdropView = BackdropView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        backdropView.collectionView.delegate = self
        backdropView.collectionView.dataSource = self
    }

    private func configureViewController() {
        view.backgroundColor = .white
        configureView()
        configureButtons()
    }

    @objc private func backSelected() {
        coordinator?.dismiss()
    }

    private func configureButtons() {
        backdropView.doneButton.addTarget(self, action: #selector(backSelected), for: .touchUpInside)
    }

    private func configureView() {
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backdropView)
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

extension BackdropViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension BackdropViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.backdropImages.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        if indexPath.row == 0 {
            guard let noSelection = collectionView.dequeueReusableCell(withReuseIdentifier: "NoSelectionCell", for: indexPath) as? NoSelectionCell else { return UICollectionViewCell() }
            cell = noSelection
        } else {
            guard let backdrop = collectionView.dequeueReusableCell(withReuseIdentifier: "BackdropCell", for: indexPath) as? BackdropCell else { return UICollectionViewCell() }
            backdrop.cellImageView.image = viewModel.backdropImages[indexPath.row - 1].image
            backdrop.cellLabel.text = viewModel.backdropImages[indexPath.row - 1].label
            cell = backdrop
        }
        return cell
    }
}

extension BackdropViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - (self.viewModel.cellSpacing * self.viewModel.numberOfSpaces)) / self.viewModel.numberOfCells
        let height: CGFloat = width * 1.17
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

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = CameraViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func dismiss() {
        navigationController.popViewController(animated: true)
    }

    func presentBackdropVC() {
        let vc = BackdropViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func presentReviewVC(data: PhotoShootData) {
        let vc = ReviewViewController(data: data)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func presentPreviewVC(image: UIImage) {
        let vc = PreviewViewController(image: image)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

import UIKit
import Photos

protocol PhotosAccess {
    func getPhotoLibraryPermission(completion: @escaping (AuthorizationStatus) -> Void)
    func requestPhotoLibraryPermission(completion: @escaping (AuthorizationStatus) -> Void)
    func presentMissingPhotosAccessAlert(viewController: UIViewController)
}

class PhotosPermissionsProvider: PhotosAccess {

    //MARK: - Photos Authorization Status
    func getPhotoLibraryPermission(completion: @escaping (AuthorizationStatus) -> Void) {
         checkPhotoLibraryPermission(completion: completion)
    }

    func requestPhotoLibraryPermission(completion: @escaping (AuthorizationStatus) -> Void) {
        requestPhotoAuthorization(completion: completion)
    }

    private func checkPhotoLibraryPermission(completion: @escaping (AuthorizationStatus) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(.authorized)
        case .denied, .restricted:
            completion(.denied)
        case .notDetermined:
            completion(.undetermined)
        @unknown default:
            completion(.denied)
        }
    }

    private func requestPhotoAuthorization(completion: @escaping (AuthorizationStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                completion(.authorized)
            case .denied, .restricted:
                completion(.denied)
            case .notDetermined:
                completion(.undetermined)
            @unknown default:
                completion(.denied)
            }
        }
    }

    //MARK: - Photos Access Alert
    func presentMissingPhotosAccessAlert(viewController: UIViewController) {
        let alertController = UIAlertController(
            title: StyleGuide
                    .AppCopy
                        .PhotosPermissions
                            .missingAccessTitle,
            message: StyleGuide
                        .AppCopy
                            .PhotosPermissions
                                .missingAccessMessage,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(
            title: StyleGuide
                    .AppCopy
                        .PhotosPermissions
                            .rhAlertButtonText,
            style: .destructive))
        alertController.addAction(UIAlertAction(
            title: StyleGuide
                    .AppCopy
                        .PhotosPermissions
                            .lhAlertButtonText,
            style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication
                    .shared
                        .open(
                            url,
                            options: [:],
                            completionHandler: nil)
            }
        })
        viewController.present(alertController, animated: true)
    }
}

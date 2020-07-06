import UIKit
import Photos

protocol PhotosAccess {
    func getPhotoLibraryPermission(completion: @escaping (AuthorizationStatus) -> Void)
    func requestPhotoLibraryPermission(completion: @escaping (AuthorizationStatus) -> Void)
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
}

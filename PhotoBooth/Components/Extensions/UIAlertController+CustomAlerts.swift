import UIKit

extension UIAlertController {
    static func makeMissingPhotosAccessAlert() -> UIAlertController {
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

        return alertController
    }

    static func makeImageSaveFailureAlert(error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: StyleGuide.AppCopy.ErrorAlerts.saveErrorTitle,
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: StyleGuide.AppCopy.ErrorAlerts.saveErrorbuttonText,
                                                style: .default))

        return alertController
    }
}

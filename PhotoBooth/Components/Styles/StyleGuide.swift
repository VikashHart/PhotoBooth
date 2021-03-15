import Foundation
import UIKit

enum StyleGuide {
    enum Assets {
        //MARK: - Application image assets
        static let appLogo = "app_logo"
        static let cameraIcon = "camera_icon"
        static let editIcon = "edit_icon"
        static let endFilterIcon = "end_filtering_icon"
        static let flashOff = "flash_off"
        static let flashOn = "flash_on"
        static let justCamera = "just_camera"
        static let launchScreen = "launch_screen"
        static let rotateCamera = "rotate_camera"
        static let saveIcon = "save_icon"
        static let selectedIcon = "selected_icon"
        static let selectionModeOff = "selection_mode_off"
        static let selectionModeOn = "selection_mode_on"
        static let shareIcon = "share_icon"
        static let simDefault = "sim_default"
        static let stepperMinus = "stepper_minus"
        static let stepperPlus = "stepper_plus"
        static let unselected = "unselected"
        static let updateBanner = "update_banner"
    }

    enum AppCopy {
        enum InterstitialVC {
            //MARK: - Connection failure alert
            static let connectionFailureTitle = "No Connection Detected"
            static let connectionFailureMessage = "Please check your wifi/data connection and retry."
            static let buttonText = "Retry"
            //MARK: - Update View
            static let laterButtonText = "Later"
            static let updateButtonText = "Update"
            static let okayButtonText = "Okay"
            //MARK: - Update Requirement Text
            static let none = ""
            static let versionUnsuported = "Your version of Lens is no longer supported."
        }

        enum CameraVC {
            //MARK: - Set up shoot card
            static let startShoot = "Start"
            static let setupCardHeaderTitle = "Timed Shoot"
            //MARK: - Camera permissions alert
            static let missingCameraAccessTitle = "Looks like camera access is denied"
            static let missingCameraAccessMessage = "In order to take pictures Lens needs access to your camera. To update your app permissions, click settings below."
            static let lhAlertButtonText = "Settings"
            static let rhAlertButtonText = "Cancel"
            //MARK: - Pre shoot card
            static let promptText = "Quickly swipe down during shoot to cancel"
        }

        enum ReviewVC {
            //MARK: - Header text
            static let exitButtonText = "Exit"
            static let selectionModeHeaderTitle = "Selecting"
            static let selectButtonText = "Select"
            static let doneButtonText = "Done"
        }

        enum PreviewVC {
            //MARK: - Button
            static let backButtonText = "Back"
        }

        enum PhotosPermissions {
            //MARK: - Photos permissions alert
            static let missingAccessTitle = "Looks like camera roll access is denied"
            static let missingAccessMessage = "In order to save pictures Lens needs access to your camera roll. To update your app permissions, click settings below."
            static let lhAlertButtonText = "Settings"
            static let rhAlertButtonText = "Cancel"
        }

        enum ErrorAlerts {
            //MARK: - Save Error
            static let saveErrorTitle = "Save Error"
            static let saveErrorbuttonText = "Ok"
        }

        enum Toolbar {
            //MARK: - Toolbar text
            static let shareText = "Share"
            static let saveText = "Save"
            static let filterText = "Filter"
            static let doneText = "Done"
        }
    }

    enum LottieAnimations {
        static let swipeDown = "swipe_down"
        static let saved = "saved"
    }

    enum HapticFeedbackType {
        @available(iOS 13.0, *)
        static let primaryFeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle.soft
        static let fallbackFeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle.medium
        static let savedFeedbackStyle =  UINotificationFeedbackGenerator.FeedbackType.success
    }

    enum StaticAppNumbers {
        static let shimmerDelay: TimeInterval = 8
        static let swipeToCancelPromptDuration: TimeInterval = 2.5
        //MARK: - Interstial View constant
        static let heightConstant: CGFloat = (UIScreen.main.bounds.height / 4)
    }

    enum CollectionView {
        enum ReviewPage {
            static let cellId = "ReviewCell"
            static let cellSpacing: CGFloat = 16
            static let numberOfCells: CGFloat = 2
            static let heightMultiplier: CGFloat = 1.6
        }

        enum PreviewPage {
            static let previewCellId = "PreviewCell"
            static let filterCellId = "FilterCell"
            static let cellSpacing: CGFloat = 6
            static let numberOfCells: CGFloat = 1
        }
    }
}

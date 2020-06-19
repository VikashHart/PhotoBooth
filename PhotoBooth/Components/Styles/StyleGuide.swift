import Foundation
import UIKit

enum StyleGuide {
    enum Assets {
        //MARK: - Application image assets
        static let cameraIcon = "camera_icon"
        static let flashOff = "flash_off"
        static let flashOn = "flash_on"
        static let justCamera = "just_camera"
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
    }

    enum AppCopy {
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
        }

        enum PhotosPermissions {
            //MARK: - Photos permissions alert
            static let missingAccessTitle = "Looks like camera roll access is denied"
            static let missingAccessMessage = "In order to save pictures Lens needs access to your camera roll. To update your app permissions, click settings below."
            static let lhAlertButtonText = "Settings"
            static let rhAlertButtonText = "Cancel"
        }

        enum Toolbar {
            //MARK: - Toolbar text
            static let shareText = "Share"
            static let saveText = "Save"
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
    }

    enum CollectionView {
        enum ReviewPage {
            private static let cells: CGFloat = 2
            static let cellId = "ReviewCell"
            static let cellSpacing: CGFloat = 5
            static let numberOfCells: CGFloat = 2
            static let numberOfSpaces: CGFloat = cells + 1
        }
    }
}

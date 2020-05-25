import Foundation

enum StyleGuide {
    enum Assets {
        static let cameraIcon = "camera_icon"
        static let flashOff = "flash_off"
        static let flashOn = "flash_on"
        static let justCamera = "just_camera"
        static let rotateCamera = "rotate_camera"
        static let selectedIcon = "selected_icon"
        static let shareIcon = "share_icon"
        static let simDefault = "sim_default"
        static let stepperMinus = "stepper_minus"
        static let stepperPlus = "stepper_plus"
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
        }
    }
}

import AVFoundation

extension AVCaptureDevice.Position {
    var positionDescription: String {
        switch self {
        case .unspecified:
            return "unspecified"
        case .back:
            return "back"
        case .front:
            return "front"
        @unknown default:
            return "unknown future case position"
        }
    }
}

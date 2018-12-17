import Foundation

extension ProcessedImage {
    var parameters: [String : Any] {
        return [
            "image_orientation" : image.orientation.description,
            "camera_position" : cameraPosition.positionDescription
        ]
    }
}

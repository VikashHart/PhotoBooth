import Foundation

extension PhotoShootData {
    var parameters: [String : Any] {
        return [
            "session_ID" : sessionID,
            "total_image_count" : images.count
        ]
    }
}

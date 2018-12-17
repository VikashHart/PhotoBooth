import Foundation

extension PhotoShootConfiguration {
    var parameters: [String : Any] {
        return [
            "session_ID" : sessionID,
            "photo_count_total" : photoCount,
            "time_interval" : timeInterval
        ]
    }
}

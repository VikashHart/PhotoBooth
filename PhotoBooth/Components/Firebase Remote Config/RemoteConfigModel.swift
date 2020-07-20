import Foundation

typealias configPayload = [RCPayload]

struct RCPayload: Codable {
    let currentVersion: String
    let minSupportedVersion: String
    let minSupportediOSVersion: String
    let alertCopy: AlertCopy
}

struct AlertCopy: Codable {
    let title: String
    let body: String
}

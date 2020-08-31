import Foundation

typealias configPayload = [RCPayload]

struct RCPayload: Codable {
    let currentVersion: Version
    let minSupportedVersion: Version
    let minSupportediOSVersion: Version
    let alertCopy: AlertCopy
    let blacklist: [Version]
}

struct AlertCopy: Codable {
    let title: String
    let subtitle: String
    let body: String
}

struct Version: Codable {
    let major: Int
    let minor: Int
    let patch: Int
}

extension Version {
    init(versionString: String) {
        let separatedVersion = versionString.components(separatedBy: ".").compactMap { (component) -> Int? in
            return Int(component)
        }
        major = separatedVersion[safe: 0] ?? 0
        minor = separatedVersion[safe: 1] ?? 0
        patch = separatedVersion[safe: 2] ?? 0
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        guard index >= 0 else { return nil }
        return index <= count - 1 ? self[index] : nil
    }
}

extension Version: CustomStringConvertible {
    var description: String {
        return "\(major).\(minor).\(patch)"
    }
}

extension Version: Comparable {
    static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major < rhs.major {
            return true
        } else if lhs.major == rhs.major {
            if lhs.minor < rhs.minor {
                return true
            } else if lhs.minor == rhs.minor {
                if lhs.patch < rhs.patch {
                    return true
                }
            }
        }
        return false
    }
}

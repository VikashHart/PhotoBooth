import Foundation

protocol ReachabilityDelegate: class {
    func reachabilityStatus(statusType: ReachabilityStatusType)
}

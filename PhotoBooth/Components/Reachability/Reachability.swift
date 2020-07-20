import SystemConfiguration

class Reachability {

    weak var delegate: ReachabilityDelegate?
    private let reachabilityNode = SCNetworkReachabilityCreateWithName(nil, "www.google.com")

    func getReachabilityStatus() {
        checkReachable()
    }

    private func checkReachable() {
        guard let reachability = reachabilityNode else { return }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)

        if (isNetworkReachable(with: flags)) {
            print(flags)
            if flags.contains(.isWWAN) {
                // **** Reachable via mobile ****
                delegate?.reachabilityStatus(statusType: .mobileConnection)
                return
            } else {
                // **** Reachable via wifi ****
                delegate?.reachabilityStatus(statusType: .wifiConnection)
                return
            }
        } else if (!isNetworkReachable(with: flags)) {
            // **** Not reachable via mobile or wifi ****
            delegate?.reachabilityStatus(statusType: .noConnection)
            print(flags)
            return
        }
    }

    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutuserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)

        return isReachable && (!needsConnection || canConnectWithoutuserInteraction)
    }
}

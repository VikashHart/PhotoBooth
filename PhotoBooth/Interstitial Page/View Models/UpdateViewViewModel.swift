import Foundation

protocol UpdateViewModeling {
    var titleText: String { get }
    var subtitleText: String { get }
    var bodyText: String { get }
    var requirementText: String { get }
}

class UpdateViewModel: UpdateViewModeling {
    var titleText: String

    var subtitleText: String

    var bodyText: String

    var requirementText: String = ""

    init(payload: RCPayload,
         requirements: String) {
        self.titleText = payload.alertCopy.title
        self.subtitleText = payload.alertCopy.subtitle
        self.bodyText = payload.alertCopy.body
        self.requirementText = requirements
    }
}

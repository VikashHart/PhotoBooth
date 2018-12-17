import Foundation

enum CancellationAction {
    case review
    case discard
    case dismiss

    var description: String {
        switch self {
        case .review:
            return "review"
        case .discard:
            return "discard"
        case .dismiss:
            return "dismiss"
        }
    }
}

class CancellationViewModel: CancellationViewModeling {
    let cancelLabelText: String = "Cancelling"

    var detailLabelText: String {
        return getDetailLabelText()
    }

    var currentNumberOfPhotos: Int

    let onActionSelected: (CancellationAction) -> Void

    init(currentNumberOfPhotos: Int, onActionSelected: @escaping (CancellationAction) -> Void) {
        self.currentNumberOfPhotos = currentNumberOfPhotos
        self.onActionSelected = onActionSelected
    }

    func reviewPressed() {
        onActionSelected(.review)
    }

    func discardPressed() {
        onActionSelected(.discard)
    }

    func dismissPressed() {
        onActionSelected(.dismiss)
    }

    private func getDetailLabelText() -> String {
        var text = ""
        switch currentNumberOfPhotos {
        case 1:
            text = "You have \(currentNumberOfPhotos) picture in your roll. What would you like to do with it?"
        default:
            text = "You have \(currentNumberOfPhotos) pictures in your roll. What would you like to do with them?"

        }
        return text
    }
}

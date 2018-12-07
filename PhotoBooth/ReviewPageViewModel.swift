import UIKit

protocol ReviewPageViewModeling {
    var isShareActive: Bool { get set }
    var isCancelHidden: Bool { get }
    var isSelectHidden: Bool { get set }
    var isDoneHidden: Bool { get }
    var shareColor: UIColor { get }
    var onSelectChanged: (() -> Void)? { get set }
}

class ReviewPageViewModel: ReviewPageViewModeling {
    var isSelectHidden: Bool {
        didSet {
            onSelectChanged?()
        }
    }

    var isDoneHidden: Bool {
        return !isSelectHidden
    }

    var isCancelHidden: Bool {
        return isSelectHidden
    }

    var isShareActive: Bool {
        didSet {
            onSelectChanged?()
        }
    }

    var shareColor: UIColor {
        return isShareActive ? UIColor.photoBoothBlue : UIColor.lightGray
    }

    var onSelectChanged: (() -> Void)?

    init(isSelectHidden: Bool = false, isShareActive: Bool = false) {
        self.isSelectHidden = isSelectHidden
        self.isShareActive = isShareActive
    }
}

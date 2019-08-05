import UIKit
import RxSwift

protocol ReviewPageViewModeling {
    var isShareActive: Bool { get set }
    var isCancelHidden: Bool { get }
    var isSelectHidden: Bool { get set }
    var isDoneHidden: Bool { get }
    var isFooterActive: Observable<Bool> { get }
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

    private let isFooterActiveSubject = BehaviorSubject<Bool>(value: false)

    lazy var isFooterActive: Observable<Bool> = {
        return self.isFooterActiveSubject.asObservable()
    }()

    var shareColor: UIColor {
        return isShareActive ? UIColor.photoBoothBlue : UIColor.lightGray
    }

    var onSelectChanged: (() -> Void)?

    private let disposeBag = DisposeBag()

    init(isSelectHidden: Bool = false,
         isShareActive: Bool = false,
         selectionCountObservable: Observable<Int>) {
        self.isSelectHidden = isSelectHidden
        self.isShareActive = isShareActive

        bindTo(selectionCount: selectionCountObservable)
    }

    private func bindTo(selectionCount: Observable<Int>) {
        selectionCount.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.updateFooter(selectCount: count)
                self?.updateShareActive(selectCount: count)
            }).disposed(by: disposeBag)
    }

    private func updateShareActive(selectCount: Int) {
        isShareActive = selectCount == 0 ? false : true
    }

    private func updateFooter(selectCount: Int) {
        switch selectCount {
        case 0: isFooterActiveSubject.onNext(false)
        case 1: isFooterActiveSubject.onNext(true)
        default: break
        }
    }
}

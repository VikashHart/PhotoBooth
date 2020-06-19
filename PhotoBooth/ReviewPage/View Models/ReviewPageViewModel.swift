import UIKit
import RxSwift

protocol ReviewPageViewModeling {
    var isCancelHidden: Bool { get }
    var isSelectHidden: Bool { get set }
    var isDoneHidden: Bool { get }
    var headerText: String { get }
    var isFooterActive: Observable<Bool> { get }
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

    var headerText: String {
        switch isSelectHidden {
        case true:
            return StyleGuide.AppCopy.ReviewVC.selectionModeHeaderTitle
        case false:
            return ""
        }
    }

    private let isFooterActiveSubject = BehaviorSubject<Bool>(value: false)

    lazy var isFooterActive: Observable<Bool> = {
        return self.isFooterActiveSubject.asObservable()
    }()

    var onSelectChanged: (() -> Void)?

    private let disposeBag = DisposeBag()

    init(isSelectHidden: Bool = false,
         selectionCountObservable: Observable<Int>) {
        self.isSelectHidden = isSelectHidden

        bindTo(selectionCount: selectionCountObservable)
    }

    private func bindTo(selectionCount: Observable<Int>) {
        selectionCount.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.updateFooter(selectCount: count)
            }).disposed(by: disposeBag)
    }

    private func updateFooter(selectCount: Int) {
        switch selectCount {
        case 0: isFooterActiveSubject.onNext(false)
        case 1: isFooterActiveSubject.onNext(true)
        default: break
        }
    }
}

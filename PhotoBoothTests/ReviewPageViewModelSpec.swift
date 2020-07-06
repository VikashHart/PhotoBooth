import UIKit
import Quick
import Nimble
import RxSwift
@testable import PhotoBooth

class ReviewPageViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: ReviewPageViewModel!
        var onSelectChanged: (() -> Void)!
        var didChange: Bool!
        var subject: BehaviorSubject<Int>!

        describe("ReviewPageViewModel") {
            beforeEach {
                subject = BehaviorSubject(value: 0)
            }

            context("When isSelectHidden is equal to false") {

                beforeEach {
                    viewModel = ReviewPageViewModel(isSelectHidden: false,
                                                    selectionCountObservable: subject.asObservable())
                }

                it("isDoneHidden should be true") {
                    expect(viewModel.isDoneHidden).to(be(true))
                }

                it("isCancelHidden should be false") {
                    expect(viewModel.isCancelHidden).to(be(false))
                }
            }

            context("When isSelectHidden is equal to true") {

                beforeEach {
                    viewModel = ReviewPageViewModel(isSelectHidden: true,
                                                    selectionCountObservable: subject.asObservable())
                }

                it("isDoneHidden should be false") {
                    expect(viewModel.isDoneHidden).to(be(false))
                }

                it("isCancelHidden should be true") {
                    expect(viewModel.isCancelHidden).to(be(true))
                }
            }

            context("When the onSelectChanged callback is called") {

                beforeEach {
                    onSelectChanged = {
                        didChange = true
                    }
                    viewModel.onSelectChanged = onSelectChanged
                    viewModel.onSelectChanged?()
                }

                it("didChange should be true") {
                    expect(didChange).to(equal(true))
                }
            }
        }
    }
}

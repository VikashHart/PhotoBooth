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

        fdescribe("ReviewPageViewModel") {
            beforeEach {
                subject = BehaviorSubject(value: 0)
            }

            context("When isSelectHidden is equal to false") {

                beforeEach {
                    viewModel = ReviewPageViewModel(isSelectHidden: false,
                                                    isShareActive: false,
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
                                                    isShareActive: false,
                                                    selectionCountObservable: subject.asObservable())
                }

                it("isDoneHidden should be false") {
                    expect(viewModel.isDoneHidden).to(be(false))
                }

                it("isCancelHidden should be true") {
                    expect(viewModel.isCancelHidden).to(be(true))
                }
            }

            context("When selection count is 0") {

                beforeEach {
                    subject.onNext(0)
                    viewModel = ReviewPageViewModel(selectionCountObservable: subject.asObservable())
                }

                it("changes isShareActive to false") {
                    expect(viewModel.isShareActive).to(beFalse())
                }

                it("shareColor should be lightGray") {
                    expect(viewModel.shareColor).to(be(UIColor.lightGray))
                }
            }

            context("When selection count goes above 0") {

                beforeEach {
                    viewModel = ReviewPageViewModel(selectionCountObservable: subject.asObservable())
                    subject.onNext(1)
                }

                it("changes isShareActive to true") {
                    expect(viewModel.isShareActive).to(beTrue())
                }

                it("shareColor should be photoBoothBlue") {
                    expect(viewModel.shareColor).to(be(UIColor.photoBoothBlue))
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

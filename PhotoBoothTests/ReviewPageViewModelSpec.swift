import UIKit
import Quick
import Nimble
@testable import PhotoBooth

class ReviewPageViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: ReviewPageViewModel!
        var onSelectChanged: (() -> Void)!
        var didChange: Bool!

        describe("ReviewPageViewModel") {
            context("When isSelectHidden is equal to false") {

                beforeEach {
                    viewModel = ReviewPageViewModel(isSelectHidden: false, isShareActive: false)
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
                    viewModel = ReviewPageViewModel(isSelectHidden: true, isShareActive: false)
                }

                it("isDoneHidden should be false") {
                    expect(viewModel.isDoneHidden).to(be(false))
                }

                it("isCancelHidden should be true") {
                    expect(viewModel.isCancelHidden).to(be(true))
                }
            }

            context("When isShareActive is equal to false") {

                beforeEach {
                    viewModel = ReviewPageViewModel(isSelectHidden: false, isShareActive: false)
                }

                it("shareColor should be lightGray") {
                    expect(viewModel.shareColor).to(be(UIColor.lightGray))
                }
            }

            context("When isShareActive is equal to true") {

                beforeEach {
                    viewModel = ReviewPageViewModel(isSelectHidden: false, isShareActive: true)
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

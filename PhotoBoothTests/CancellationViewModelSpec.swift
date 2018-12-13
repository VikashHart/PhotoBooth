import Quick
import Nimble
@testable import PhotoBooth

class CancellationViewModelSpec: QuickSpec {

    override func spec() {

        var viewModel: CancellationViewModel!
        var cancelAction: CancellationAction!
        var onActionSelected: ((CancellationAction) -> Void)!

        describe("CancellationViewModel") {
            context("When the view model is initialized with a currentNumberOfPhotos equal to 1") {

                beforeEach {
                    onActionSelected = {
                        action in
                        cancelAction = action
                    }

                    viewModel = CancellationViewModel(currentNumberOfPhotos: 1, onActionSelected: onActionSelected)
                }

                it("the cancellation text label should be 'Canceling'") {
                    expect(viewModel.cancelLabelText).to(be("Cancelling"))
                }

                it("detailTextLabel should be 'You have 1 picture in your roll. What would you like to do with it?'") {
                    expect(viewModel.detailLabelText).to(equal("You have 1 picture in your roll. What would you like to do with it?"))
                }

                context("and the reviewPressed func is called") {

                    beforeEach {
                        viewModel.reviewPressed()
                    }

                    it("cancellationAction will return .review") {
                        expect(cancelAction).to(equal(CancellationAction.review))
                    }
                }

                context("and the discardPressed function is called") {

                    beforeEach {
                        viewModel.discardPressed()
                    }

                    it("cancellationAction will return .discard") {
                        expect(cancelAction).to(equal(CancellationAction.discard))
                    }
                }

                context("and the dismissPressed function is called") {

                    beforeEach {
                        viewModel.dismissPressed()
                    }

                    it("cancellationAction will return .dismiss") {
                        expect(cancelAction).to(equal(CancellationAction.dismiss))
                    }
                }

            }

            context("When the view model is initialized with a currentNumberOfPhotos equal to 2") {
                beforeEach {
                    onActionSelected = {
                        action in
                        cancelAction = action
                    }

                    viewModel = CancellationViewModel(currentNumberOfPhotos: 2, onActionSelected: onActionSelected)
                }

                it("detailTextLabel should be 'You have 2 pictures in your roll. What would you like to do with them?'") {
                    expect(viewModel.detailLabelText).to(equal("You have 2 pictures in your roll. What would you like to do with them?"))
                }
            }
        }
    }
}

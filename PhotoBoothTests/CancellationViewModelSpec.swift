import Quick
import Nimble
@testable import PhotoBooth

class CancellationViewModelSpec: QuickSpec {

    override func spec() {

        var viewModel: CancellationViewModel!
        var cancelAction: CancellationAction!
        var onActionSelected: ((CancellationAction) -> Void)!

        fdescribe("CancellationViewModel") {
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

                context("and when the cancellation action is .review") {

                    beforeEach {
                        viewModel.reviewPressed()
                    }

                    it("cancellationAction will return .review") {
                        expect(cancelAction).to(equal(CancellationAction.review))
                    }
                }

                context("and when the cancellation action is .discard") {

                    beforeEach {
                        viewModel.discardPressed()
                    }

                    it("cancellationAction will return .discard") {
                        expect(cancelAction).to(equal(CancellationAction.discard))
                    }
                }

                context("and when the cancellation action is .dismiss") {

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

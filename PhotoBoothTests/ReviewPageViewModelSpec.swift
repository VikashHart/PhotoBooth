import Quick
import Nimble
import UIKit
@testable import PhotoBooth

class ReviewPageViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: ReviewPageViewModel!

       fdescribe("ReviewPageViewModel") {
            context("When I instantiate the viewModel with an array of images") {

                beforeEach {
                    let images = [UIImage(), UIImage(), UIImage()]
                    viewModel = ReviewPageViewModel(capturedImages: images)
                }

                context("And I press add") {
                    let index: IndexPath = IndexPath(row: 0, section: 0)

                    beforeEach {
                        viewModel.add(index: index)
                    }

                    it("Should add an element to the selected indices array") {
                        expect(viewModel.selectedIndices).to(equal([index]))
                    }
                }

                context("And I press remove") {
                    let index: IndexPath = IndexPath(row: 0, section: 0)

                    beforeEach {
                        viewModel.remove(index: index)
                    }

                    it("Should remove the selected element from the selected indices array") {
                        expect(viewModel.selectedIndices).to(equal([]))
                    }
                }

                context("And I call the deselectAll function") {

                    beforeEach {
                        viewModel.deselectAll()
                    }

                    it("Should clear the selected indices") {
                        expect(viewModel.selectedIndices).to(be([]))
                    }
                }
            }
        }
    }
}

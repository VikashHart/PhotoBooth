import Quick
import Nimble
@testable import PhotoBooth

class ReviewCellViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: ReviewCellViewModel!

        describe("ReviewCellViewModel") {
            context("When I instantiate the cell viewModel") {

                beforeEach {
                    let image = UIImage()
                    viewModel = ReviewCellViewModel(isSelected: false, image: image)
                }

                context("if the selected state is false") {

                    beforeEach {
                        viewModel.isSelected = false
                    }

                    it("the selection alpha should be 0") {
                        expect(viewModel.selectionAlpha).to(be(0))
                    }
                }

                context("if the selected state is true") {

                    beforeEach {
                        viewModel.isSelected = true
                    }

                    it("the selection alpha should be 0") {
                        expect(viewModel.selectionAlpha).to(be(0.5))
                    }
                }
            }
        }
    }
}

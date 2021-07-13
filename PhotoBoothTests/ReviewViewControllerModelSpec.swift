import Quick
import Nimble
import UIKit
@testable import PhotoBooth

class ReviewViewControllerModelSpec: QuickSpec {

    override func spec() {
        var viewModel: ReviewViewControllerModel!
        var reloadIndices: (([IndexPath]) -> Void)!
        var indices: [IndexPath]!
        var didChange: Bool!

        describe("ReviewPageViewModel") {
            context("When I instantiate the viewModel with an array of images") {

                beforeEach {
                    let images = [UIImage(), UIImage(), UIImage()]
                    viewModel = ReviewViewControllerModel(data: PhotoShootData(sessionID: "1234", images: images))
                }

                context("When I call get viewModel") {
                    let indexPath: IndexPath = IndexPath(row: 1, section: 0)
                    var cellViewModel: ReviewCellModeling!

                    beforeEach {
                        cellViewModel = viewModel.getCellViewModel(indexPath: indexPath)
                    }

                    it("should return a cellViewModel with selected value of false") {
                        expect(cellViewModel.isSelected).to(be(false))
                    }

                    it("should return a UIImage") {
                        expect(cellViewModel.image).to(be(viewModel.capturedImages[0]))
                    }
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
                        indices = [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)]
                        reloadIndices = { indexes in
                            indices = indexes
                            didChange = true
                        }
                        viewModel.reloadIndices = reloadIndices
                        viewModel.deselectAll()
                        viewModel.reloadIndices?(indices)
                    }

                    it("Should clear the selected indices") {
                        expect(viewModel.selectedIndices).to(be([]))
                    }

                    it("Should change the didChange property to true") {
                        expect(didChange).to(equal(true))
                    }
                }

                context("When I call the selectPressed function") {

                    beforeEach {
                        viewModel.selectPressed()
                    }

                    it("isSelectable should be true") {
                        expect(viewModel.isSelectable).to(equal(true))
                    }

                    it("reviewViewModel.isSelectHidden should be true") {
                        expect(viewModel.reviewViewModel.isSelectHidden)
                            .to(equal(true))
                    }
                }

                context("When I call the donePressed function") {

                    beforeEach {
                        viewModel.donePressed()
                    }

                    it("isSelectable should be false") {
                        expect(viewModel.isSelectable).to(equal(false))
                    }

                    it("reviewViewModel.isSelectHidden should be false") {
                        expect(viewModel.reviewViewModel.isSelectHidden)
                            .to(equal(false))
                    }
                }
            }
        }
    }
}

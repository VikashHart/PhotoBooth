import Quick
import Nimble
@testable import PhotoBooth

class TopShotCellViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: TopShotCellViewModel!
        var onSelectionChanged: (() -> Void)!
        var didChange: Bool!

        describe("TopShotCellViewModel") {
            context("When I instantiate the cell viewModel") {

                beforeEach {
                    let images = [UIImage()]
                    viewModel = TopShotCellViewModel(images: images)
                }

                context("if the selected state is false") {

                    beforeEach {
                        viewModel.isSelected = false
                    }

                    it("the selection alpha should be 0") {
                        expect(viewModel.selectionAlpha).to(equal(0))
                    }
                }

                context("if the selected state is true") {

                    beforeEach {
                        viewModel.isSelected = true
                    }

                    it("the selection alpha should be 0.33") {
                        expect(viewModel.selectionAlpha).to(equal(0.33))
                    }
                }

                context("When onSelectionChanged is called") {

                    beforeEach {
                        onSelectionChanged = {
                            didChange = true
                        }
                        viewModel.onSelectionChanged = onSelectionChanged
                        viewModel.onSelectionChanged?()
                    }

                    it("Should change the didChange property to true") {
                        expect(didChange).to(equal(true))
                    }
                }
            }
        }
    }
}

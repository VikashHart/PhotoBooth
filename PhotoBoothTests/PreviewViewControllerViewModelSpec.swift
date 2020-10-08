import UIKit
import Quick
import Nimble
@testable import PhotoBooth

class PreviewViewControllerViewMoldelSpec: QuickSpec {

    override func spec() {
        var viewModel: PreviewViewControllerModel!

        describe("PreviewViewControllerViewModel") {

            context("when the view model is initialized with an index of IndexPath(0,0") {

                beforeEach {
                    let images = [UIImage(), UIImage(), UIImage()]
                    viewModel = PreviewViewControllerModel(data: PhotoShootData(sessionID: "testID", images: images), selectedIndex: IndexPath(row: 0, section: 0))
                }

                it("viewModel selectedIndex should be IndexPath(0,0)") {
                    expect(viewModel.selectedIndex).to(be(IndexPath(row: 0, section: 0)))
                }

                it("viewModel selectedImage should be images[0]") {
                    expect(viewModel.selectedImage).to(be(viewModel.images[0]))
                }

                context("when setSelectedImageAndIndex is called with a value of IndexPath(1,0") {

                    beforeEach {
                        viewModel.setSelectedImageAndIndex(indexPath: IndexPath(row: 1, section: 0))
                    }

                    it("viewmodel selectedIndex should be IndexPath(1,0") {
                        expect(viewModel.selectedIndex).to(be(IndexPath(row: 1, section: 0)))
                    }

                    it("viewModel selectedImage should be images[1]") {
                        expect(viewModel.selectedImage).to(be(viewModel.images[1]))
                    }
                }

                context("when getCellViewModel is called with a value of IndexPath(0,0)") {
                    var cellViewModel: PreviewCellModeling!

                    beforeEach {
                        cellViewModel = viewModel.getCellViewModel(indexPath: IndexPath(row: 0, section: 0))
                    }

                    it("cell viewModel should have an isSelected value of true") {
                        expect(cellViewModel.isSelected).to(equal(true))
                    }
                }

                context("when getCellViewModel is called with a value of IndexPath(1,0)") {
                    var cellViewModel: PreviewCellModeling!

                    beforeEach {
                        cellViewModel = viewModel.getCellViewModel(indexPath: IndexPath(row: 1, section: 0))
                    }

                    it("cell viewModel should have an isSelected value of false") {
                        expect(cellViewModel.isSelected).to(equal(false))
                    }
                }
            }
        }
    }
}

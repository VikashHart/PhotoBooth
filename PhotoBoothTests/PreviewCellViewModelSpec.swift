import UIKit
import Quick
import Nimble
@testable import PhotoBooth

class PreviewCellViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: PreviewCellViewModel!
        var isSelectedChanged: (() -> Void)!
        var didChange: Bool!

        describe("PreviewCellViewModel") {

            beforeEach {
                viewModel = PreviewCellViewModel(cellImage: UIImage())
            }

            context("when the viewModel is instantiated with a default isSelected parameter") {

                it("viewModel isSelected should equal false") {
                    expect(viewModel.isSelected).to(equal(false))
                }
            }

            context("when the isSelectedChanged callback is called") {

                beforeEach {
                    isSelectedChanged = {
                        didChange = true
                    }

                    viewModel.isSelectedChanged = isSelectedChanged
                    viewModel.isSelectedChanged?()
                }

                it("didChange should be equal to true") {
                    expect(didChange).to(equal(true))
                }
            }

            context("when setCellSelection is called with a value of true") {

                beforeEach {
                    viewModel.setCellSelection(state: true)
                }

                it("viewModel isSelected should equal true") {
                    expect(viewModel.isSelected).to(be(true))
                }
            }
        }
    }
}

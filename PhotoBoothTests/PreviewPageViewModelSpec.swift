import UIKit
import Quick
import Nimble
@testable import PhotoBooth

class PreviewPageViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: PreviewViewModel!
        var onImageChanged: (() -> Void)!
        var didChange: Bool!

        describe("PreviewViewModel") {

            context("When the onImageChanged callback is called") {

                beforeEach {
                    viewModel = PreviewViewModel(image: UIImage(), imageIdentifier: "test")
                    onImageChanged = {
                        didChange = true
                    }
                    viewModel.onImageChanged = onImageChanged
                    viewModel.onImageChanged?()
                }

                it("didChange should be true") {
                    expect(didChange).to(be(true))
                }
            }
        }
    }
}

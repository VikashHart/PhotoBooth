import Quick
import Nimble
@testable import PhotoBooth

class CountdownIndicatorViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: CountdownIndicatorViewModel!

        describe("CountdownIndicatorViewModel") {
            context("when I pass a value of 0 to the view model") {

                beforeEach {
                    viewModel = CountdownIndicatorViewModel(time: 0)
                }

                it("should create a label text of '0'") {
                    expect(viewModel.timerLabelText).to(be("0"))

                }
            }
        }
    }
}

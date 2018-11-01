import Quick
import Nimble
@testable import PhotoBooth

class SwipeToCancelPromptSpec: QuickSpec {

    override func spec() {
        var swipeToCanceViewModel: SwipeToCancelPromptViewModel!

        describe("SwipeToCancelViewModel") {
            context("when the view model is initailized the promt text will not be nil") {

                beforeEach {
                    swipeToCanceViewModel = SwipeToCancelPromptViewModel()
                }

                it("the prompt text will be 'Quickly swipe down at any time to cancel'") {
                    expect(swipeToCanceViewModel.promptText)
                        .to(match("Quickly swipe down at any time to cancel"))
                }
            }
        }
    }
}

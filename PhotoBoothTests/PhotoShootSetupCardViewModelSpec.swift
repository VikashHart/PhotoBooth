import Quick
import Nimble
@testable import PhotoBooth

class PhotoShootSetupCardViewModelSpec: QuickSpec {

    override func spec() {

        var photoShootSetupCardViewModel: PhotoShootSetupCardViewModel!
        var onConfigure: ((PhotoShootConfiguration) -> ())!
        var photoStepperViewModel: PhotoStepperViewModel!
        var timeIntervalStepperViewModel: TimeIntervalStepperViewModel!
        var configuration: PhotoShootConfiguration!

        describe("PhotoShootSetupCardViewModel") {
            context("when the PhotoShootSetupCardViewModel is initialized"){

                it("has titleText of 'Set up your photoshoot'") {
                    expect(PhotoShootSetupCardViewModel(onConfigure: { _ in }).titleText)
                        .to(match("Set up your photoshoot"))
                }

                context("and the photoStepperViewModel initial value is 3") {
                    context("and the timerStepperViewModel initial value is 5"){

                        beforeEach {
                            photoStepperViewModel = PhotoStepperViewModel(initialValue: 3, min: 1, max: 10)
                            timeIntervalStepperViewModel = TimeIntervalStepperViewModel(initialValue: 5, min: 1, max: 10)
                            onConfigure = { config in
                                configuration = config
                            }
                            photoShootSetupCardViewModel = PhotoShootSetupCardViewModel(onConfigure: onConfigure, photoStepperViewModel: photoStepperViewModel, timerStepperViewModel: timeIntervalStepperViewModel)
                        }

                        context("when finalizeConfiguration() is called") {
                            it("calls the onConfigure closure with a configuration matching the expected values") {
                                expect(configuration).to(beNil())
                                photoShootSetupCardViewModel.finalizeConfiguration()

                                expect(configuration).toNot(beNil())
                                expect(configuration.photoCount)
                                    .to(be(photoStepperViewModel.currentValue))
                                expect(configuration.timeInterval)
                                    .to(be(timeIntervalStepperViewModel.currentValue))
                            }
                        }
                    }
                }

            }
        }
    }
}

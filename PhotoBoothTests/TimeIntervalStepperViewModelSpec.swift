import Quick
import Nimble
@testable import PhotoBooth

class TimeIntervalStepperViewModelSpec: QuickSpec {

    override func spec() {

        var timeIntervalStepperViewModel: TimeIntervalStepperViewModel!

        describe("timeIntervalStepperViewModel") {
            context("when the initial value is 1") {
                context("and the minimum is 1 and maximum is 10") {

                    beforeEach {
                        timeIntervalStepperViewModel = TimeIntervalStepperViewModel(initialValue: 1, min: 1, max: 10)
                    }

                    it("has a currentValue of 1") {
                        expect(timeIntervalStepperViewModel.currentValue).to(be(1))
                    }
                    it("has a minusEnabled value of false") {
                        expect(timeIntervalStepperViewModel.minusEnabled).to(beFalse())
                    }
                    it("has a plusEnabled value of true") {
                        expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                    }
                    it("the stepper label text is '1 second apart'") {
                        expect(timeIntervalStepperViewModel.labelText).to(match("1 second apart"))
                    }

                    context("and minusTapped is called") {

                        beforeEach {
                            timeIntervalStepperViewModel.minusTapped()
                        }

                        it("the current value stays at 1") {
                            expect(timeIntervalStepperViewModel.currentValue).to(be(1))
                        }
                        it("the minusEnabled remains false") {
                            expect(timeIntervalStepperViewModel.minusEnabled).to(beFalse())
                        }
                        it("the plus enabled remains true") {
                            expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '1 second apart'") {
                            expect(timeIntervalStepperViewModel.labelText).to(match("1 second apart"))
                        }
                    }

                    context("and plusTapped is called") {

                        beforeEach {
                            timeIntervalStepperViewModel.plusTapped()
                        }

                        it("the current value changes to 2") {
                            expect(timeIntervalStepperViewModel.currentValue).to(be(2))
                        }
                        it("the minusEnabled changes to true") {
                            expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled remains true") {
                            expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '2 seconds apart'") {
                            expect(timeIntervalStepperViewModel.labelText).to(match("2 seconds apart"))
                        }
                    }
                }
            }

            context("when the initial value is 2") {
                context("and the minimum is 1 and maximum is 10") {

                    beforeEach {
                        timeIntervalStepperViewModel = TimeIntervalStepperViewModel(initialValue: 2, min: 1, max: 10)
                    }

                    it("has a currentValue of 2") {
                        expect(timeIntervalStepperViewModel.currentValue).to(be(2))
                    }
                    it("has a minusEnabled value of true") {
                        expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                    }
                    it("has a plusEnabled value of true") {
                        expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                    }
                    it("the stepper label text is '2 seconds apart'") {
                        expect(timeIntervalStepperViewModel.labelText).to(match("2 seconds apart"))
                    }

                    context("and minusTapped is called") {

                        beforeEach {
                            timeIntervalStepperViewModel.minusTapped()
                        }

                        it("the current value changes to 1") {
                            expect(timeIntervalStepperViewModel.currentValue).to(be(1))
                        }
                        it("the minusEnabled changes to false") {
                            expect(timeIntervalStepperViewModel.minusEnabled).to(beFalse())
                        }
                        it("the plus enabled remains true") {
                            expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '1 second apart'") {
                            expect(timeIntervalStepperViewModel.labelText).to(match("1 second apart"))
                        }
                    }

                    context("and plusTapped is called") {

                        beforeEach {
                            timeIntervalStepperViewModel.plusTapped()
                        }

                        it("the current value changes to 3") {
                            expect(timeIntervalStepperViewModel.currentValue).to(be(3))
                        }
                        it("the minusEnabled changes to true") {
                            expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled remains true") {
                            expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '3 seconds apart'") {
                            expect(timeIntervalStepperViewModel.labelText).to(match("3 seconds apart"))
                        }
                    }
                }
            }

            context("when the initial value is 9") {
                context("and the minimum is 1 and maximum is 10") {

                    beforeEach {
                        timeIntervalStepperViewModel = TimeIntervalStepperViewModel(initialValue: 9, min: 1, max: 10)
                    }

                    it("has a currentValue of 9") {
                        expect(timeIntervalStepperViewModel.currentValue).to(be(9))
                    }
                    it("has a minusEnabled value of true") {
                        expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                    }
                    it("has a plusEnabled value of true") {
                        expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                    }
                    it("the stepper label text is '9 seconds apart'") {
                        expect(timeIntervalStepperViewModel.labelText).to(match("9 seconds apart"))
                    }

                    context("and minusTapped is called") {

                        beforeEach {
                            timeIntervalStepperViewModel.minusTapped()
                        }

                        it("the current value stays at 8") {
                            expect(timeIntervalStepperViewModel.currentValue).to(be(8))
                        }
                        it("the minusEnabled remains true") {
                            expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled remains true") {
                            expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '8 seconds apart'") {
                            expect(timeIntervalStepperViewModel.labelText).to(match("8 seconds apart"))
                        }
                    }

                    context("and plusTapped is called") {

                        beforeEach {
                            timeIntervalStepperViewModel.plusTapped()
                        }

                        it("the current value changes to 10") {
                            expect(timeIntervalStepperViewModel.currentValue).to(be(10))
                        }
                        it("the minusEnabled remains true") {
                            expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled changes to false") {
                            expect(timeIntervalStepperViewModel.plusEnabled).to(beFalse())
                        }
                        it("the stepper label text is '10 seconds apart'") {
                            expect(timeIntervalStepperViewModel.labelText).to(match("10 seconds apart"))
                        }
                    }
                }
            }

            context("when the initial value is 10") {
                context("and the minimum is 1 and maximum is 10") {

                    beforeEach {
                        timeIntervalStepperViewModel = TimeIntervalStepperViewModel(initialValue: 10, min: 1, max: 10)
                    }

                    it("has a currentValue of 10") {
                        expect(timeIntervalStepperViewModel.currentValue).to(be(10))
                    }
                    it("has a minusEnabled value of true") {
                        expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                    }
                    it("has a plusEnabled value of false") {
                        expect(timeIntervalStepperViewModel.plusEnabled).to(beFalse())
                    }
                    it("the stepper label text is '10 seconds apart'") {
                        expect(timeIntervalStepperViewModel.labelText).to(match("10 seconds apart"))
                    }

                    context("and minusTapped is called") {

                        beforeEach {
                            timeIntervalStepperViewModel.minusTapped()
                        }

                        it("the current value changes to 9") {
                            expect(timeIntervalStepperViewModel.currentValue).to(be(9))
                        }
                        it("the minusEnabled remains true") {
                            expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled changes to true") {
                            expect(timeIntervalStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '9 seconds apart'") {
                            expect(timeIntervalStepperViewModel.labelText).to(match("9 seconds apart"))
                        }
                    }

                    context("and plusTapped is called") {

                        beforeEach {
                            timeIntervalStepperViewModel.plusTapped()
                        }

                        it("the current value stays at 10") {
                            expect(timeIntervalStepperViewModel.currentValue).to(be(10))
                        }
                        it("the minusEnabled remains true") {
                            expect(timeIntervalStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled remains false") {
                            expect(timeIntervalStepperViewModel.plusEnabled).to(beFalse())
                        }
                        it("the stepper label text is '10 seconds apart'") {
                            expect(timeIntervalStepperViewModel.labelText).to(match("10 seconds apart"))
                        }
                    }
                }
            }
        }
    }
}

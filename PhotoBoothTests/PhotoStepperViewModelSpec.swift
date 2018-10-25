import XCTest
import Quick
import Nimble
@testable import PhotoBooth

class PhotoStepperViewModelSpec: QuickSpec {

    override func spec() {
        var photoStepperViewModel: PhotoStepperViewModel!

        describe("PhotoStepperViewModel") {
            context("when the initial value is 1") {
                context("and the minimum is 1 and maximum is 10") {

                    beforeEach {
                        photoStepperViewModel = PhotoStepperViewModel(initialValue: 1, min: 1, max: 10)
                    }

                    it("has a currentValue of 1") {
                        expect(photoStepperViewModel.currentValue).to(be(1))
                    }
                    it("has a minusEnabled value of false") {
                        expect(photoStepperViewModel.minusEnabled).to(beFalse())
                    }
                    it("has a plusEnabled value of true") {
                        expect(photoStepperViewModel.plusEnabled).to(beTrue())
                    }
                    it("the stepper label text is '1 photo'") {
                        expect(photoStepperViewModel.labelText).to(be("1 photo"))
                    }

                    context("and minusTapped is called") {

                        beforeEach {
                            photoStepperViewModel.minusTapped()
                        }

                        it("the current value stays at 1") {
                            expect(photoStepperViewModel.currentValue).to(be(1))
                        }
                        it("the minusEnabled remains false") {
                            expect(photoStepperViewModel.minusEnabled).to(beFalse())
                        }
                        it("the plus enabled remains true") {
                            expect(photoStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '1 photo'") {
                            expect(photoStepperViewModel.labelText).to(be("1 photo"))
                        }
                    }

                    context("and plusTapped is called") {

                        beforeEach {
                            photoStepperViewModel.plusTapped()
                        }

                        it("the current value changes to 2") {
                            expect(photoStepperViewModel.currentValue).to(be(2))
                        }
                        it("the minusEnabled changes to true") {
                            expect(photoStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled remains true") {
                            expect(photoStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '2 photos'") {
                            expect(photoStepperViewModel.labelText).to(be("2 photos"))
                        }
                    }
                }
            }

            context("when the initial value is 2") {
                context("and the minimum is 1 and the maximum is 10"){

                    beforeEach {
                        photoStepperViewModel = PhotoStepperViewModel(initialValue: 2, min: 1, max: 10)
                    }

                    it("has a currentValue of 2") {
                        expect(photoStepperViewModel.currentValue).to(be(2))
                    }
                    it("has a minusEnabled value of true") {
                        expect(photoStepperViewModel.minusEnabled).to(beTrue())
                    }
                    it("has a plusEnabled value of true") {
                        expect(photoStepperViewModel.plusEnabled).to(beTrue())
                    }
                    it("the stepper label text is '2 photos'") {
                        expect(photoStepperViewModel.labelText).to(be("2 photos"))
                    }

                    context("and minusTapped is called") {

                        beforeEach {
                            photoStepperViewModel.minusTapped()
                        }

                        it("the current value changes to 1") {
                            expect(photoStepperViewModel.currentValue).to(be(1))
                        }
                        it("the minusEnabled changes to false") {
                            expect(photoStepperViewModel.minusEnabled).to(beFalse())
                        }
                        it("the plus enabled remains true") {
                            expect(photoStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '1 photo'") {
                            expect(photoStepperViewModel.labelText).to(be("1 photo"))
                        }
                    }

                    context("and plusTapped is called") {

                        beforeEach {
                            photoStepperViewModel.plusTapped()
                        }

                        it("the current value changes to 3") {
                            expect(photoStepperViewModel.currentValue).to(be(3))
                        }
                        it("the minusEnabled remains true") {
                            expect(photoStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled remains true") {
                            expect(photoStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '3 photos'") {
                            expect(photoStepperViewModel.labelText).to(be("3 photos"))
                        }
                    }
                }
            }

            context("when the initial value is 9") {
                context("and the minimum is 1 and the maximum is 10"){

                    beforeEach {
                        photoStepperViewModel = PhotoStepperViewModel(initialValue: 9, min: 1, max: 10)
                    }

                    it("has a currentValue of 9") {
                        expect(photoStepperViewModel.currentValue).to(be(9))
                    }
                    it("has a minusEnabled value of true") {
                        expect(photoStepperViewModel.minusEnabled).to(beTrue())
                    }
                    it("has a plusEnabled value of true") {
                        expect(photoStepperViewModel.plusEnabled).to(beTrue())
                    }
                    it("the stepper label text is '9 photos'") {
                        expect(photoStepperViewModel.labelText).to(be("9 photos"))
                    }

                    context("and minusTapped is called") {

                        beforeEach {
                            photoStepperViewModel.minusTapped()
                        }

                        it("the current value changes to 8") {
                            expect(photoStepperViewModel.currentValue).to(be(8))
                        }
                        it("the minusEnabled remains true") {
                            expect(photoStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled remains true") {
                            expect(photoStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '8 photos'") {
                            expect(photoStepperViewModel.labelText).to(be("8 photos"))
                        }
                    }

                    context("and plusTapped is called") {

                        beforeEach {
                            photoStepperViewModel.plusTapped()
                        }

                        it("the current value changes to 10") {
                            expect(photoStepperViewModel.currentValue).to(be(10))
                        }
                        it("the minusEnabled remains true") {
                            expect(photoStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled changes to false") {
                            expect(photoStepperViewModel.plusEnabled).to(beFalse())
                        }
                        it("the stepper label text is '10 photos'") {
                            expect(photoStepperViewModel.labelText).to(be("10 photos"))
                        }
                    }
                }
            }
            context("when the initial value is 10") {
                context("and the minimum is 1 and the maximum is 10"){

                    beforeEach {
                        photoStepperViewModel = PhotoStepperViewModel(initialValue: 10, min: 1, max: 10)
                    }

                    it("has a currentValue of 10") {
                        expect(photoStepperViewModel.currentValue).to(be(10))
                    }
                    it("has a minusEnabled value of true") {
                        expect(photoStepperViewModel.minusEnabled).to(beTrue())
                    }
                    it("has a plusEnabled value of false") {
                        expect(photoStepperViewModel.plusEnabled).to(beFalse())
                    }
                    it("the stepper label text is '10 photos'") {
                        expect(photoStepperViewModel.labelText).to(be("10 photos"))
                    }

                    context("and minusTapped is called") {

                        beforeEach {
                            photoStepperViewModel.minusTapped()
                        }

                        it("the current value changes to 9") {
                            expect(photoStepperViewModel.currentValue).to(be(9))
                        }
                        it("the minusEnabled remains true") {
                            expect(photoStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plusEnabled changes to true ") {
                            expect(photoStepperViewModel.plusEnabled).to(beTrue())
                        }
                        it("the stepper label text is '9 photos'") {
                            expect(photoStepperViewModel.labelText).to(be("9 photos"))
                        }
                    }

                    context("and plusTapped is called") {

                        beforeEach {
                            photoStepperViewModel.plusTapped()
                        }

                        it("the current value stays at 10") {
                            expect(photoStepperViewModel.currentValue).to(be(10))
                        }
                        it("the minusEnabled remains true") {
                            expect(photoStepperViewModel.minusEnabled).to(beTrue())
                        }
                        it("the plus enabled remains false") {
                            expect(photoStepperViewModel.plusEnabled).to(beFalse())
                        }
                        it("the stepper label text is '10 photos'") {
                            expect(photoStepperViewModel.labelText).to(be("10 photos"))
                        }
                    }
                }
            }
        }
    }
}

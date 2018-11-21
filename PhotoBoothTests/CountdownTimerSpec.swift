import Quick
import Nimble
@testable import PhotoBooth

class CountdownTimerSpec: QuickSpec {

    override func spec() {
        var timer: CountdownTimer!
        var countdownArray: [Int]!

        describe("Countdown Timer") {
            context("When the timer is initialized with a value of 5") {

                afterEach {
                    timer.stopTimer()
                    timer = nil
                }

                beforeEach {
                    countdownArray = [Int]()
                    timer = CountdownTimer(seconds: 2) { timeRemaining in
                        countdownArray.append(timeRemaining)
                    }
                    timer.startTimer()
                }

                it("will return an array containing 2,1,0") {

                    expect(countdownArray).toEventually(equal([2,1,0]), timeout: 2.1, pollInterval: 1, description: nil)

                }

                context("and reset timer is called") {

                    beforeEach {
                        timer.restartTimer()
                    }

                    it("should have a time remaining value of '2'") {
                        expect(timer.timeRemaining).to(equal(2))
                    }

                    it("will return an array containing 2,1,0") {

                    expect(countdownArray).toEventually(equal([2,2,1,0]), timeout: 2.1, pollInterval: 1, description: nil)

                    }
                }
            }
        }
    }
}

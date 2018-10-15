import Quick
import Nimble

class QuickNimbleDemoTestFile: QuickSpec {
    override func spec() {
        describe("Quick Nimble Demo Test File") {
            context("when this is a test") {
                it("passes") {
                    expect(2+2).to(equal(4))
                }
            }
        }
    }
}

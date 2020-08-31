import Foundation
import Quick
import Nimble
@testable import PhotoBooth

class VersionSpec: QuickSpec {

    override func spec() {
        var lhs: Version!
        var rhs: Version!
        describe("Comparable: <") {

            context("when lhs major < rhs major") {
                beforeEach {
                    lhs = Version(major: 1, minor: 0, patch: 0)
                    rhs = Version(major: 3, minor: 0, patch: 0)
                }

                it("returns true") {
                    expect(lhs < rhs).to(equal(true))
                }
            }

            context("when lhs major > rhs major") {
                beforeEach {
                    lhs = Version(major: 3, minor: 0, patch: 0)
                    rhs = Version(major: 1, minor: 0, patch: 0)
                }

                it("returns false") {
                    expect(lhs < rhs).to(equal(false))
                }
            }

            context("when lhs major == rhs major") {

                context("when lhs minor < rhs minor") {
                    beforeEach {
                        lhs = Version(major: 1, minor: 0, patch: 0)
                        rhs = Version(major: 1, minor: 1, patch: 0)
                    }

                    it("returns true") {
                        expect(lhs < rhs).to(equal(true))
                    }
                }

                context("when lhs minor > rhs minor") {
                    beforeEach {
                        lhs = Version(major: 1, minor: 1, patch: 0)
                        rhs = Version(major: 1, minor: 0, patch: 0)
                    }

                    it("returns false") {
                        expect(lhs < rhs).to(equal(false))
                    }
                }

                context("when lhs minor == rhs minor") {

                    context("when lhs patch < rhs patch") {
                        beforeEach {
                            lhs = Version(major: 1, minor: 1, patch: 0)
                            rhs = Version(major: 1, minor: 1, patch: 1)
                        }

                        it("returns true") {
                            expect(lhs < rhs).to(equal(true))
                        }
                    }

                    context("when lhs patch > rhs patch") {
                        beforeEach {
                            lhs = Version(major: 1, minor: 1, patch: 1)
                            rhs = Version(major: 1, minor: 1, patch: 0)
                        }

                        it("returns false") {
                            expect(lhs < rhs).to(equal(false))
                        }
                    }

                    context("when lhs patch == rhs patch") {
                        beforeEach {
                            lhs = Version(major: 1, minor: 1, patch: 1)
                            rhs = Version(major: 1, minor: 1, patch: 1)
                        }

                        it("returns false") {
                            expect(lhs < rhs).to(equal(false))
                        }
                    }
                }
            }
        }
    }
}

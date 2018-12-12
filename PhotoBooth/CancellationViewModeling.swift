import Foundation

protocol CancellationViewModeling {
    var cancelLabelText: String { get }
    var detailLabelText: String { get }
    var currentNumberOfPhotos: Int { get set }

    func reviewPressed()
    func discardPressed()
    func dismissPressed()
}

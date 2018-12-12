import UIKit

class SwipeToCancelPartialModal: PartialModal {
    lazy var view: UIView = {
        let viewModel = CancellationViewModel(currentNumberOfPhotos: numberOfPhotos,
                                                         onActionSelected: {[weak self] action in
                                                            self?.process(action: action)
        })
        return CancellationPartialModalView(viewModel: viewModel)
    }()

    var delegate: PartialModalDelegate?

    private let numberOfPhotos: Int
    private let onActionSelected: (CancellationAction, PartialModal) -> Void

    init(numberOfPhotos: Int, onActionSelected: @escaping (CancellationAction, PartialModal) -> Void) {
        self.numberOfPhotos = numberOfPhotos
        self.onActionSelected = onActionSelected
    }

    func process(action: CancellationAction) {
        onActionSelected(action, self)
    }
}

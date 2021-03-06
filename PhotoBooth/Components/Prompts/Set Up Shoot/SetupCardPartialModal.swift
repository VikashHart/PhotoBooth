import UIKit

class SetUpCardPartialModal: PartialModal {
    lazy var view: UIView = {
        let setupCardViewModel = SetupCardViewModel(onConfigure:
        { [weak self] configuration in
            guard let strongSelf = self else { return }
            strongSelf.onConfigureFinalized(configuration, strongSelf)
        })
        let view = SetupCardView(viewModel: setupCardViewModel)
        return view
    }()

    var delegate: PartialModalDelegate?
    private let onConfigureFinalized: ((PhotoShootConfiguration, SetUpCardPartialModal) -> Void)

    init(onConfigureFinalized: @escaping (PhotoShootConfiguration, SetUpCardPartialModal) -> Void) {
        self.onConfigureFinalized = onConfigureFinalized
    }
}

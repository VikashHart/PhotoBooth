import UIKit

class SwipeToCancelPromptPartialModal: PartialModal {
    lazy var view: UIView = {
        let swipeToCancelViewModel = SwipeToCancelPromptViewModel()
        let view = SwipeToCancelPromptView(viewModel: swipeToCancelViewModel)
        return view
    }()

    var delegate: PartialModalDelegate?
}

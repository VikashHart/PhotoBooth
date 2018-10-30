import UIKit

class SwipeToCancelPromptPartialModal: PartialModal {
    var view: UIView = {
        let swipeToCancelViewModel = SwipeToCancelPromptViewModel()
        let view = SwipeToCancelPromptView(viewModel: swipeToCancelViewModel)
        return view
    }()

    var delegate: PartialModalDelegate?
}

import UIKit

class CancellationPartialModalView: UIView {

    let viewModel: CancellationViewModeling

    lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.cancelLabelText
        label.font = UIFont.mediumFont(size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.detailLabelText
        label.font = UIFont.mediumFont(size: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Review", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.photoBoothBlue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(review), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var discardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Discard All", for: .normal)
        button.setTitleColor(UIColor.photoBoothBlue, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.photoBoothBlue.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(discard), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(UIColor.photoBoothBlue, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: CancellationViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }

    override func layoutSubviews() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    private func setupViews() {
        setupCancelLabel()
        setupDetailLabel()
        setupReviewButton()
        setupDiscardButton()
        setupDismissButton()
    }

    private func setupCancelLabel() {
        addSubview(cancelLabel)
        NSLayoutConstraint.activate([
            cancelLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cancelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cancelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cancelLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }

    private func setupDetailLabel() {
        addSubview(detailLabel)
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: cancelLabel.bottomAnchor, constant: 16),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            detailLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }

    private func setupReviewButton() {
        addSubview(reviewButton)
        NSLayoutConstraint.activate([
            reviewButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20),
            reviewButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reviewButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            reviewButton.heightAnchor.constraint(equalTo: reviewButton.widthAnchor, multiplier: 0.3),
            ])
    }

    private func setupDiscardButton() {
        addSubview(discardButton)
        NSLayoutConstraint.activate([
            discardButton.topAnchor.constraint(equalTo: reviewButton.bottomAnchor, constant: 16),
            discardButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            discardButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            discardButton.heightAnchor.constraint(equalTo: reviewButton.widthAnchor, multiplier: 0.3)
            ])
    }

    private func setupDismissButton() {
        addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: discardButton.bottomAnchor, constant: 10),
            dismissButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dismissButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            dismissButton.heightAnchor.constraint(equalTo: reviewButton.widthAnchor, multiplier: 0.3),
            dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
    }

    @objc private func review() {
        viewModel.reviewPressed()
    }

    @objc private func discard() {
        viewModel.discardPressed()
    }

    @objc private func dismiss() {
        viewModel.dismissPressed()
    }

}

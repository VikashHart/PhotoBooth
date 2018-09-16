import UIKit

class CameraView: UIView {
    
    lazy var previewLayerContainer: UIView = {
        let pl = UIView()
        pl.translatesAutoresizingMaskIntoConstraints = false
        return pl
    }()
    
    lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "rotate_camera").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupPreviewLayerContainer()
        setupSwitchCameraButton()
    }
    
    private func setupPreviewLayerContainer() {
        addSubview(previewLayerContainer)
        NSLayoutConstraint.activate([
            previewLayerContainer.topAnchor.constraint(equalTo: topAnchor),
            previewLayerContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewLayerContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewLayerContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            previewLayerContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            previewLayerContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    private func setupSwitchCameraButton() {
        previewLayerContainer.addSubview(switchCameraButton)
        NSLayoutConstraint.activate([
            switchCameraButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            switchCameraButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            switchCameraButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            switchCameraButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
            ])
    }
    
}


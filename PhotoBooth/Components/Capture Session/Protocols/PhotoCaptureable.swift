import AVFoundation

protocol PhotoCaptureable {
    var onImageCaptured: ((ProcessedImage) -> Void)? { get set }

    func captureImage()

    func configurePreview(view: AVCapturePreviewView)

    func switchCamera()

    func getFlashMode() -> AVCaptureDevice.FlashMode

    func setFlashMode(mode: FlashStatus)

    func focus(touchLocation: CGPoint)

    func minMaxZoom(_ factor: CGFloat) -> CGFloat

    func updateZoomScaleFactor(scale factor: CGFloat)

    func updateOrientation(orientation: AVCaptureVideoOrientation)
}

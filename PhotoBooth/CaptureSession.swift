import UIKit
import AVFoundation

protocol PhotoCaptureable {

    func captureImage() -> UIImage

    func configurePreview(view: AVCapturePreviewView)

    func switchCamera()
}

class CaptureSession: NSObject, PhotoCaptureable, AVCapturePhotoCaptureDelegate {

    private var avSession = AVCaptureSession()

    private var backCamera: AVCaptureDevice?
    private var frontCamera: AVCaptureDevice?
    private var currentCamera: AVCaptureDevice?

    private var photoOutput: AVCapturePhotoOutput?
    private let photoSessionPreset = AVCaptureSession.Preset.photo

    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer?

    private var images = [UIImage]()

    private func setupCaptureSession() {
        setupPhotoCaptureSession()
        setupDevices()
        setUpCaptureSessionInput(position: .front)
    }

    func captureImage() -> UIImage {
        return UIImage()
    }

    func configurePreview(view: AVCapturePreviewView) {
        setupCaptureSession()
        setupPreviewLayer(view: view)
        startRunningCaptureSession()
    }

    // This function sets up a switch to change the camera in use depending on current position when called.
    private func setUpCaptureSessionInput(position: AVCaptureDevice.Position) {
        switch position {
        case .back:
            currentCamera = backCamera
        case .front:
            currentCamera = frontCamera
        default:
            currentCamera = backCamera
        }

        setupInputOutput()
    }

    // Mark:- @objc functions for buttons
    // This is the function that will be called when the take photo button is pressed.
    @objc func takePhoto(){
        avSession.beginConfiguration()
        avSession.sessionPreset = photoSessionPreset
        avSession.commitConfiguration()

        DispatchQueue.main.async {
            let settings = AVCapturePhotoSettings()
            self.photoOutput?.capturePhoto(with: settings, delegate: self)
        }
    }

    // This function switches the camera.
    @objc func switchCamera() {
        guard let currentPosition = currentCamera?.position else { return }
        let newPosition: AVCaptureDevice.Position = currentPosition == .back ? .front : .back
        setUpCaptureSessionInput(position: newPosition)
    }

    // Mark:- AVCapture Session Setup functions
    // This function sets up the photo capture session as well as the photo ouput instance and its settings.
    private func setupPhotoCaptureSession(){
        photoOutput = AVCapturePhotoOutput()
        photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        avSession.addOutput(photoOutput!)
    }

    // This function allows you to have the application discover the devices camera(s)
    private func setupDevices(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices

        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
    }

    // This function allows you to remove the current camera input in use and to set and enable a new camera input.
    private func setupInputOutput(){
        avSession.beginConfiguration()
        if let currentInput = avSession.inputs.first {
            avSession.removeInput(currentInput)
        }
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            avSession.addInput(captureDeviceInput)
        } catch {
            print(error)
        }
        avSession.commitConfiguration()
    }

    // This function creates a layer in the view that will enable a live feed of what your camera is observing.
    private func setupPreviewLayer(view: UIView){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: avSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }

    // Starts running the capture session after you set up the view.
    private func startRunningCaptureSession(){
        avSession.startRunning()
    }

    // AVCapturePhotoCaptureDelegate methods. This extension is used because you need to wait until the photo you took "didFinishProcessing" before you can handle the image.
    private func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            let image = UIImage(data: imageData)
//            guard let image = image else { return }
//            let previewVC = PreviewViewController(image: image)
//            previewVC.delegate = self
//            present(previewVC, animated: true, completion: nil)

        }
    }

}

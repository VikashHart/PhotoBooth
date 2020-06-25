import UIKit
import PromiseKit
import Photos

final class PhotosAlbumSaveTask: NSObject, ImageSaving {
    private var taskResolver: Resolver<Void>?
    
    func saveImage(image: UIImage) -> Promise<Void> {
        return Promise<Void> { (resolver) in
            taskResolver = resolver
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            taskResolver?.reject(error)
        } else {
            taskResolver?.fulfill_()
        }
    }
}

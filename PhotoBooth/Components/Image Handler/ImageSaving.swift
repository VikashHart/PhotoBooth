import UIKit
import PromiseKit

protocol ImageSaving {
    func saveImage(image: UIImage) -> Promise<Void>
}

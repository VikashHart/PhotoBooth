import UIKit
import CoreImage

extension UIImage {
    func applyFilter(filter name: String, completion: @escaping (UIImage) -> Void) {
        guard name != "Original" else { return completion(self) }
        DispatchQueue.global(qos: .userInitiated).async {
            let cleanedImage = self.fixOrientation()
            let ciimg = CIImage(image: cleanedImage)
            let filter = CIFilter(name: name)
            filter?.setValue(ciimg, forKey: kCIInputImageKey)
            guard let cgimg = Filtering.shared.context.createCGImage((filter?.outputImage)!, from: ciimg!.extent) else { return }
            let processedImage = UIImage(cgImage: cgimg)

            DispatchQueue.main.async {
                completion(processedImage)
            }
        }
    }
}

import UIKit
import CoreImage

extension UIImage {
    func applyFilter(context: CIContext, filter name: String, completion: @escaping (UIImage) -> Void) {
        guard name != "Original" else { return completion(self) }
        DispatchQueue.global(qos: .userInitiated).async {
            let cleanedImage = self.fixOrientation()
            let ciimg = CIImage(image: cleanedImage)
            let filter = CIFilter(name: name)
            filter?.setValue(ciimg, forKey: kCIInputImageKey)
            let cgimg = context.createCGImage((filter?.outputImage)!, from: ciimg!.extent)!
            let processedImage = UIImage(cgImage: cgimg)

            DispatchQueue.main.async {
                completion(processedImage)
            }
        }
    }
}

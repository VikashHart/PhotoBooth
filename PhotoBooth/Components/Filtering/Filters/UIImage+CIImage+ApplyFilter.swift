import UIKit
import CoreImage

extension UIImage {
    func applyFilter(filter: FilterObject, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let cleanedImage = self.fixOrientation()
            guard let ciimg = CIImage(image: cleanedImage) else { return }
            
            switch filter.category {
            case .none:
                DispatchQueue.main.async {
                    completion(self)
                }
            case .auto:
                let filter = AutoFilter()
                let image = filter.apply(image: ciimg)
                guard let cgimg = Filtering.shared.context.createCGImage(image, from: image.extent) else { return }

                let processedImage = UIImage(cgImage: cgimg)

                DispatchQueue.main.async {
                    completion(processedImage)
                }
            case .standard:
                let filter = ImageFilter(filter: filter)
                let image = filter.apply(image: ciimg)
                guard let cgimg = Filtering.shared.context.createCGImage(image, from: image.extent) else { return }

                let processedImage = UIImage(cgImage: cgimg)

                DispatchQueue.main.async {
                    completion(processedImage)
                }
            }
        }
    }
}

import UIKit

struct UniversalImageObject {
    let filters: [FilterObject]
    let outputImage: UIImage
    let inputImage: UIImage
    
    init(filters: [FilterObject] = [],
         originalImage: UIImage = UIImage()) {
        self.filters = filters
        self.outputImage = originalImage
        self.inputImage = originalImage
    }
}

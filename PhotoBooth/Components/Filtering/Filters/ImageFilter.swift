import CoreImage

class ImageFilter: ImageFiltering {
    var name: String
    var parameters: [String:Any]

    init(filter: FilterObject) {
        self.name = filter.designation
        self.parameters = filter.inputs
    }

    func apply(image: CIImage) -> CIImage {
        guard let filter = CIFilter(name: name) else { return image }
        filter.setValue(image, forKey: kCIInputImageKey)

        if !parameters.isEmpty{
            for (key, value) in parameters {
                filter.setValue(value, forKey: key)
            }
        }

        guard let outputImage = filter.outputImage else { return image }

        return outputImage
    }
}

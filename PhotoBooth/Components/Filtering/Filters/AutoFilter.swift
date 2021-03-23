import CoreImage

class AutoFilter: ImageFiltering {

    func apply(image: CIImage) -> CIImage {
        var image = image

        var options: [CIImageAutoAdjustmentOption: Any] = [.enhance: true]
        let orientationKey = kCGImagePropertyOrientation as String
        if let orientation: NSNumber = image.properties[orientationKey] as? NSNumber {
            options[CIImageAutoAdjustmentOption(rawValue: CIDetectorImageOrientation)] = orientation
        }
        let filters = image.autoAdjustmentFilters(options: options)
        for filter in filters {
            filter.setValue(image, forKey: kCIInputImageKey)
            guard let newImage = filter.outputImage else { return CIImage() }
            image = newImage
        }
        let outputImage = image

        return outputImage
    }
}

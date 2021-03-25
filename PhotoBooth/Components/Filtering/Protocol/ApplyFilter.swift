import CoreImage

protocol ImageFiltering {
    func apply(image: CIImage) -> CIImage
}


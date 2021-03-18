import UIKit
protocol filtering {
    var context: CIContext { get }
    var filters: [FilterObject] { get }
}

class Filtering: filtering {
    static let shared: filtering = Filtering()

    let context: CIContext = CIContext()
    let filters: [FilterObject] =
        [FilterObject(category: "Original", designation: "Original", name: "Original"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectChrome", name: "Photo Effect Chrome"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectInstant", name: "Photo Effect Instant"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectProcess", name: "Photo Effect Process"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectTonal", name: "Photo Effect Tonal"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectTransfer", name: "Photo Effect Transfer"),
         FilterObject(category: "Color Effect", designation: "CISepiaTone", name: "Sepia Tone"),
         FilterObject(category: "Halftone Effect", designation: "CIHatchedScreen", name: "Hatched Screen"),
         FilterObject(category: "Stylize", designation: "CIComicEffect", name: "Comic Effect"),
    ]
}

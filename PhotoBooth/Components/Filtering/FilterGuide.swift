import Foundation
protocol filtering {
    var filters: [FilterObject] { get }
}

class FilterGuide: filtering {
    static let shared: filtering = FilterGuide()
    let filters: [FilterObject] =
        [FilterObject(category: "Original", designation: "Original", name: "Original"),
         FilterObject(category: "Blur", designation: "CIGaussianBlur", name: "Gaussian Blur"),
         FilterObject(category: "Color Effect", designation: "CIColorPosterize", name: "Color Posterize"),
         FilterObject(category: "Color Effect", designation: "CIMinimumComponent", name: "Minimum Component"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectChrome", name: "Photo Effect Chrome"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectFade", name: "Photo Effect Fade"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectInstant", name: "Photo Effect Instant"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectMono", name: "Photo Effect Mono"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectProcess", name: "Photo Effect Process"),
         FilterObject(category: "Color Effect", designation: "CIPhotoEffectTransfer", name: "Photo Effect Transfer"),
         FilterObject(category: "Color Effect", designation: "CISepiaTone", name: "Sepia Tone")
    ]

//        [FilterObject(category: "Blur", designation: "Original", name: "Original"),
//         FilterObject(category: "Blur", designation: "CIGaussianBlur", name: "Blur"),
//         FilterObject(category: "Color Effect", designation: "CIPhotoEffectInstant", name: "Instant"),
//         FilterObject(category: "Color Effect", designation: "CIPhotoEffectMono", name: "Mono"),
//         FilterObject(category: "Color Effect", designation: "CIColorPosterize", name: "Posterize")
//    ]
}

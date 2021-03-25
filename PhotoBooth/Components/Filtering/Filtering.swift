import UIKit
protocol filtering {
    var context: CIContext { get }
    var filters: [FilterObject] { get }
}

class Filtering: filtering {
    static let shared: filtering = Filtering()

    let context: CIContext = CIContext()
    let filters: [FilterObject] =
        [FilterObject(category: FilterType.none,
                      designation: "Original",
                      name: "Original",
                      inputs: [:]),
         FilterObject(category: FilterType.auto,
                      designation: "Auto",
                      name: "Otto",
                      inputs: [:]),
         FilterObject(category: FilterType.standard,
                      designation: "CITemperatureAndTint",
                      name: "Vice",
                      inputs: [
                        "inputNeutral" : CIVector(x: 6500, y: 0),
                        "inputTargetNeutral" : CIVector(x: 5200, y: 0)
                      ]),
         FilterObject(category: FilterType.standard,
                      designation: "CITemperatureAndTint",
                      name: "Eleanor",
                      inputs: [
                        "inputNeutral" : CIVector(x: 6500, y: 0),
                        "inputTargetNeutral" : CIVector(x: 9000, y: 0)
                      ]),
         FilterObject(category: FilterType.standard,
                      designation: "CIPhotoEffectInstant",
                      name: "Winchester",
                      inputs: [:]),
         FilterObject(category: FilterType.standard,
                      designation: "CIPhotoEffectChrome",
                      name: "Magnum",
                      inputs: [:]),
         FilterObject(category: FilterType.standard,
                      designation: "CIPhotoEffectMono",
                      name: "Obsidian",
                      inputs: [:]),
         FilterObject(category: FilterType.standard,
                      designation: "CIHatchedScreen",
                      name: "Akira",
                      inputs: [:])
    ]
}

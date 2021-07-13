import UIKit
import Vision

class ImageQualityDetection {

    func analyzeImages(images: [UIImage], completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var topShot = AnalyzedImage(image: UIImage(), score: 0)
            var topShotImage = UIImage()

            for image in images {
                guard let cgImg = image.cgImage else { continue }
                let request = VNDetectFaceCaptureQualityRequest()
                request.revision = VNDetectFaceCaptureQualityRequestRevision1
                let requestHandler = VNImageRequestHandler(cgImage: cgImg)
                do {
                    try requestHandler.perform([request])
                } catch {
                    print("could not process request")
                }
                let observation = request.results?.first as? VNFaceObservation
                let score = observation?.faceCaptureQuality

                if let imgScore = score, imgScore > topShot.score {
                    topShot = AnalyzedImage(image: image, score: imgScore)
                }
            }

            switch topShot.score {
            case 0:
                if let image = images.randomElement() {
                    topShotImage = image
                }
            default:
                topShotImage = topShot.image
            }

            DispatchQueue.main.async {
                completion(topShotImage)
            }
        }
    }
}

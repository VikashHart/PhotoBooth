import UIKit

class HapticFeedback {
    static let shared = HapticFeedback()

    func playHaptic(feedback type: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.prepare()
        generator.impactOccurred()
    }

    func playFallback() {
        // Fallback on earlier versions
        let generator = UIImpactFeedbackGenerator(style: StyleGuide.HapticFeedbackType.mediumFeedbackStyle)
        generator.prepare()
        generator.impactOccurred()
    }
}

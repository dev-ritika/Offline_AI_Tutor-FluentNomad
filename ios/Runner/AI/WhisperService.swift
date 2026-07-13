import Foundation

final class WhisperService {

    private let bridge = WhisperBridge()

    private(set) var isModelLoaded = false

    @discardableResult
    func loadModel(at modelPath: String) -> Bool {

        if isModelLoaded {
            return true
        }

        guard FileManager.default.fileExists(atPath: modelPath) else {
            print("❌ Model not found")
            return false
        }


        let success = bridge.loadModel(modelPath)


        isModelLoaded = success

        return success
    }

    func releaseModel() {
        bridge.releaseModel()
        isModelLoaded = false
    }
}

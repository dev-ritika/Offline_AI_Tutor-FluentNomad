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

        var error: NSError?

        let success = bridge.loadModel(modelPath)
        
        bridge.loadModel(modelPath)

        if let error {
            print(error)
        }

        isModelLoaded = success

        return success
    }

    func releaseModel() {
        bridge.releaseModel()
        isModelLoaded = false
    }
}

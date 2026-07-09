import Foundation

final class WhisperService {

    private let bridge = WhisperBridge()

    func loadModel(at path: String) throws {
        try bridge.loadModel(path)
    }

    func isLoaded() -> Bool {
        bridge.isLoaded()
    }

    func release() {
        bridge.releaseModel()
    }
}
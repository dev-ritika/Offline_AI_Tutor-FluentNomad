import Foundation

final class WhisperService {

    private let bridge = WhisperBridge()

    private let audioConverter = AudioConverter()

    private(set) var isModelLoaded = false

    func convertAudio(at audioPath: String) -> String? {

    do {

    print("Calling converter...")

    let wavPath = try audioConverter.convertToWav(from: audioPath)

    print("Returned from converter")
    print(wavPath)

    return wavPath

} catch let error as NSError {

    print("Converter threw")
    print("Domain:", error.domain)
    print("Code:", error.code)
    print("Description:", error.localizedDescription)
    print(error.userInfo)

    return nil

}
}

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

    func transcribe(audioPath: String) -> String {

    guard isModelLoaded else {
        return "Model not loaded"
    }

    return bridge.transcribe(audioPath)
}
}

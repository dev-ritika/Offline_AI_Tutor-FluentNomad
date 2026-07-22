import Foundation

final class WhisperService {

    private let bridge = WhisperBridge()

    private let audioConverter = AudioConverter()

    private(set) var isModelLoaded = false

    var progressHandler: ((Int) -> Void)? {

    didSet {

        bridge.progressHandler = { progress in
            self.progressHandler?(Int(progress))
        }

    }


}

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

private func transcribeSync(audioPath: String) throws -> String {

    guard isModelLoaded else {
        throw WhisperError.modelNotLoaded
    }

    let text = try bridge.transcribe(audioPath)

    return text
}

func transcribe(
    audioPath: String,
    completion: @escaping (Result<String, Error>) -> Void
) {

    DispatchQueue.global(qos: .userInitiated).async {

    do {

        let text = try self.transcribeSync(
            audioPath: audioPath
        )

        DispatchQueue.main.async {

            completion(.success(text))

        }

    } catch {

        DispatchQueue.main.async {

            completion(.failure(error))

        }

    }

}
}

}

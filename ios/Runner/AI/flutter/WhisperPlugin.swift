import Flutter
import Foundation

class WhisperPlugin: NSObject {

    private let whisperService = WhisperService()

    let progressStreamHandler = ProgressStreamHandler()

    private let transcriptStreamHandler: TranscriptStreamHandler
    
    private let audioLevelMonitor = AudioLevelMonitor()

    let audioLevelStreamHandler = AudioLevelStreamHandler()


    init(
        transcriptStreamHandler: TranscriptStreamHandler
    ) {

        self.transcriptStreamHandler = transcriptStreamHandler

        super.init()
    }

    func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {

            print(
    "Handler:",
    ObjectIdentifier(transcriptStreamHandler)
)

        switch call.method {

        case "loadModel":
            handleLoadModel(call, result: result)

        case "transcribe":
            handleTranscribe(call, result: result)

        case "convertAudio":
            handleConvertAudio(call, result: result)

        case "isModelLoaded":
            result(whisperService.isModelLoaded)

        case "cancel":
    whisperService.cancel()
    result(nil)

        case "startAudioLevel":
    handleStartAudioLevel(result: result)

case "stopAudioLevel":
    handleStopAudioLevel(result: result)

        default:
            result(FlutterMethodNotImplemented)

        
    }

    }

    private func handleLoadModel(
    _ call: FlutterMethodCall,
    result: @escaping FlutterResult
) {

    guard
        let args = call.arguments as? [String: Any],
        let path = args["path"] as? String
    else {

        result(
            FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "Missing model path",
                details: nil
            )
        )

        return
    }

    let success = whisperService.loadModel(at: path)

    result(success)
}

private func handleTranscribe(
    _ call: FlutterMethodCall,
    result: @escaping FlutterResult
) {


    print("🔥 Swift received transcribe call")

    guard
        let args = call.arguments as? [String: Any],
        let audioPath = args["audioPath"] as? String
    else {

        result(
            FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "Missing audio path",
                details: nil
            )
        )

        return
    }


    whisperService.progressHandler = { [weak self] progress in

        DispatchQueue.main.async {

        self?.progressStreamHandler.eventSink?(progress)

    }


    }

whisperService.segmentHandler = { [weak self] text in

    DispatchQueue.main.async {

        self?.transcriptStreamHandler.eventSink?(text)

    }

}

    whisperService.transcribe(audioPath: audioPath) { response in

    switch response {

    case .success(let text):

        result(text)

    case .failure(let error):

        result(
            FlutterError(
                code: "TRANSCRIPTION_ERROR",
                message: error.localizedDescription,
                details: nil
            )
        )
    }
}
}

private func handleConvertAudio(
    _ call: FlutterMethodCall,
    result: @escaping FlutterResult
) {

    guard
        let args = call.arguments as? [String: Any],
        let path = args["path"] as? String
    else {

        result(
            FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "Missing audio path",
                details: nil
            )
        )

        return
    }

    let wavPath = whisperService.convertAudio(at: path)

    result(wavPath)
}


private func handleStartAudioLevel(
    result: @escaping FlutterResult
) {

    audioLevelMonitor.levelHandler = { [weak self] level in

        self?.audioLevelStreamHandler.eventSink?(level)

    }

    do {

        try audioLevelMonitor.start()

        result(nil)

    } catch {

        result(
            FlutterError(
                code: "AUDIO_LEVEL_START_ERROR",
                message: error.localizedDescription,
                details: nil
            )
        )
    }
}


private func handleStopAudioLevel(
    result: @escaping FlutterResult
) {

    audioLevelMonitor.stop()

    audioLevelMonitor.levelHandler = nil

    result(nil)
}


}

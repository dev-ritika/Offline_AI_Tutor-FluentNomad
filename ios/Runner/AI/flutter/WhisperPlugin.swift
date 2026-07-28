import Flutter
import Foundation

class WhisperPlugin: NSObject {

    private let whisperService = WhisperService()

    let progressStreamHandler = ProgressStreamHandler()

    func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {

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

        self?.progressStreamHandler.eventSink?(progress)

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

}

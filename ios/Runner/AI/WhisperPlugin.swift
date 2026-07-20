import Flutter
import Foundation

class WhisperPlugin: NSObject {

    private let whisperService = WhisperService()

    func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {

        switch call.method {

        case "loadModel":

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

        case "transcribe":

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

    let text = whisperService.transcribe(audioPath: audioPath)

    result(text)

    case "convertAudio":

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
        
        case "getTranscriptedText":

            result(FlutterMethodNotImplemented)

        case "isModelLoaded":
             result(whisperService.isModelLoaded)

        default:

            result(FlutterMethodNotImplemented)
        }
    }
}

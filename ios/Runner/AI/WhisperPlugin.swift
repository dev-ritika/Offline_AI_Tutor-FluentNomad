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

            do {

                try whisperService.loadModel(at: path)

                result(true)

            } catch {

                result(
                    FlutterError(
                        code: "LOAD_FAILED",
                        message: error.localizedDescription,
                        details: nil
                    )
                )
            }

        case "getTranscriptedText":

            result(FlutterMethodNotImplemented)

        default:

            result(FlutterMethodNotImplemented)
        }
    }
}
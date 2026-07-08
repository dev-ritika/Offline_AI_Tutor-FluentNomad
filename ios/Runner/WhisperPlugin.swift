import Flutter
import UIKit

class WhisperPlugin: NSObject {

    private let whisperService = WhisperService()

    func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
s
        switch call.method {

        case "hello":
            result("Hello Flutter")

        case "transcribe":
            result(FlutterMethodNotImplemented)

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
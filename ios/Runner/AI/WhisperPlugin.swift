//
//  WhisperPlugin.swift
//  Runner
//
//  Created by el RED on 08/07/26.
//

import Flutter
import UIKit

class WhisperPlugin: NSObject {

    private let whisperService = WhisperService()

    func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {

        switch call.method {

        case "getTranscriptedText":
        guard let args = call.arguments as? [String: Any] else {
        result(
            FlutterError(
                code: "INVALID_ARGS",
                message: nil,
                details: nil
            )
        )
        return
    }

    let modelPath = args["modelPath"] as? String ?? ""
    let audioPath = args["audioPath"] as? String ?? ""
    let language = args["language"] as? String ?? "en"

    do {

        let text = try whisperService.transcribe(
            modelPath: modelPath,
            audioPath: audioPath,
            language: language
        )

        result(text)

    } catch {

        result(
            FlutterError(
                code: "WHISPER_ERROR",
                message: error.localizedDescription,
                details: nil
            )
        )

    }

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

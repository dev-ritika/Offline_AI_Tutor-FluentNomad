//
//  WhisperPlugin.swift
//  Runner
//
//  Created by el RED on 08/07/26.
//


import Flutter
import UIKit

class WhisperPlugin: NSObject {


    func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {

        switch call.method {

        case "getTranscriptedText":
            result("Hello Flutter")

        case "transcribe":
            result(FlutterMethodNotImplemented)

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

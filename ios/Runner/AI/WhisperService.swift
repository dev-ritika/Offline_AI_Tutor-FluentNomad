//
//  WhisperService.swift
//  Runner
//
//  Created by el RED on 08/07/26.
//

import Foundation
import whisper

class WhisperService {

    init() {
        print("WhisperService initialized")
    }

    func transcribe(
        modelPath: String,
        audioPath: String,
        language: String
    ) throws -> String {

        return "Not implemented"
    }
}

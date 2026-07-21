import Foundation

enum WhisperError: LocalizedError {

    case modelNotLoaded
    case unknown

    var errorDescription: String? {

        switch self {

        case .modelNotLoaded:
            return "Model not loaded"

        case .unknown:
            return "Unknown transcription error"
        }
    }
}
import Foundation
import AVFoundation

final class AudioConverter {

    func convertToWav(from inputPath: String) throws -> String {

        print("Input path:", inputPath)

        let inputURL = URL(fileURLWithPath: inputPath)

        guard FileManager.default.fileExists(atPath: inputURL.path) else {
            throw NSError(
                domain: "AudioConverter",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Input file does not exist"
                ]
            )
        }

        let asset = AVURLAsset(url: inputURL)

        guard let audioTrack = asset.tracks(withMediaType: .audio).first else {
            throw NSError(
                domain: "AudioConverter",
                code: 2,
                userInfo: [
                    NSLocalizedDescriptionKey: "No audio track found"
                ]
            )
        }


        let outputURL = inputURL
            .deletingPathExtension()
            .appendingPathExtension("wav")


        if FileManager.default.fileExists(atPath: outputURL.path) {
            try FileManager.default.removeItem(at: outputURL)
        }


        let inputFile: AVAudioFile

        do {
            inputFile = try AVAudioFile(
                forReading: inputURL
            )
        } catch {
            print("AVAudioFile read failed:", error)
            throw error
        }


        let inputFormat = inputFile.processingFormat

        print("""
        Input format:
        Sample Rate: \(inputFormat.sampleRate)
        Channels: \(inputFormat.channelCount)
        Format: \(inputFormat)
        """)


        guard let outputFormat = AVAudioFormat(
            commonFormat: .pcmFormatInt16,
            sampleRate: 16000,
            channels: 1,
            interleaved: true
        ) else {
            throw NSError(
                domain: "AudioConverter",
                code: 3,
                userInfo: [
                    NSLocalizedDescriptionKey: "Could not create output format"
                ]
            )
        }


        let outputFile: AVAudioFile

        do {

let settings: [String: Any] = [
    AVFormatIDKey: kAudioFormatLinearPCM,
    AVSampleRateKey: 16000,
    AVNumberOfChannelsKey: 1,
    AVLinearPCMBitDepthKey: 16,
    AVLinearPCMIsFloatKey: false,
    AVLinearPCMIsBigEndianKey: false,
    AVLinearPCMIsNonInterleaved: false
]

            outputFile = try AVAudioFile(
    forWriting: outputURL,
    settings: settings,
    commonFormat: .pcmFormatInt16,
    interleaved: true
)
        } catch {
            print("Output file creation failed:", error)
            throw error
        }


      guard let converter = AVAudioConverter(
    from: inputFormat,
    to: outputFormat
) else {
    throw NSError(
        domain: "AudioConverter",
        code: 4,
        userInfo: [
            NSLocalizedDescriptionKey: "Converter creation failed"
        ]
    )
}


let inputFrames = AVAudioFrameCount(inputFile.length)


guard let inputBuffer = AVAudioPCMBuffer(
    pcmFormat: inputFormat,
    frameCapacity: inputFrames
) else {
    throw NSError(
        domain: "AudioConverter",
        code: 5,
        userInfo: [
            NSLocalizedDescriptionKey: "Input buffer creation failed"
        ]
    )
}


try inputFile.read(into: inputBuffer)



let outputFrameCapacity = AVAudioFrameCount(
    Double(inputFrames) *
    outputFormat.sampleRate /
    inputFormat.sampleRate
)


guard let outputBuffer = AVAudioPCMBuffer(
    pcmFormat: outputFormat,
    frameCapacity: outputFrameCapacity
) else {
    throw NSError(
        domain: "AudioConverter",
        code: 6,
        userInfo: [
            NSLocalizedDescriptionKey: "Output buffer creation failed"
        ]
    )
}


var inputConsumed = false

let status = converter.convert(
    to: outputBuffer,
    error: nil
) { _, outStatus in

    if inputConsumed {
        outStatus.pointee = .endOfStream
        return nil
    }

    inputConsumed = true
    outStatus.pointee = .haveData

    return inputBuffer
}



print("Convert status:", status)
print("Converted frames:", outputBuffer.frameLength)



guard outputBuffer.frameLength > 0 else {
    throw NSError(
        domain: "AudioConverter",
        code: 7,
        userInfo: [
            NSLocalizedDescriptionKey:
            "No converted audio frames"
        ]
    )
}

print(outputBuffer.frameCapacity)
print(outputBuffer.frameLength)

print("==========")

print(outputBuffer.frameLength)
print(outputBuffer.frameCapacity)

print(outputBuffer.format)

print(outputFile.processingFormat)

print(outputFile.fileFormat)

print(outputBuffer.audioBufferList.pointee.mNumberBuffers)

let audioBuffer = outputBuffer.audioBufferList.pointee.mBuffers

print(audioBuffer.mData as Any)
print(audioBuffer.mDataByteSize)
print(audioBuffer.mNumberChannels)

print("==========")

try outputFile.write(
    from: outputBuffer
)


        print("WAV created:", outputURL.path)

        print("""
Output format:
Sample Rate: \(outputFormat.sampleRate)
Channels: \(outputFormat.channelCount)
Frames: \(outputBuffer.frameLength)
""")

        return outputURL.path
    }
}
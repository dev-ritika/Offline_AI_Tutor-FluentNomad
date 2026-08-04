 import AVFoundation

final class AudioLevelMonitor {

    private let audioEngine = AVAudioEngine()

    var levelHandler: ((Double) -> Void)?

    private(set) var isRunning = false

    func start() throws {

        guard !isRunning else {
            return
        }

        let audioSession = AVAudioSession.sharedInstance()

        try audioSession.setCategory(
            .record,
            mode: .measurement,
            options: [.duckOthers]
        )

        try audioSession.setActive(true)

        let inputNode = audioEngine.inputNode

        let inputFormat = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(
            onBus: 0,
            bufferSize: 1024,
            format: inputFormat
        ) { [weak self] buffer, _ in

            guard let self else {
                return
            }

            let level = self.calculateLevel(buffer)

            DispatchQueue.main.async {
                self.levelHandler?(level)
            }
        }

        audioEngine.prepare()

        try audioEngine.start()

        isRunning = true
    }

    func stop() {

        guard isRunning else {
            return
        }

        audioEngine.inputNode.removeTap(onBus: 0)

        audioEngine.stop()

        try? AVAudioSession.sharedInstance().setActive(
            false,
            options: .notifyOthersOnDeactivation
        )

        isRunning = false
    }

    private func calculateLevel(
        _ buffer: AVAudioPCMBuffer
    ) -> Double {

        guard let channelData = buffer.floatChannelData else {
            return 0.0
        }

        let channel = channelData[0]

        let frameLength = Int(buffer.frameLength)

        guard frameLength > 0 else {
            return 0.0
        }

        var sum: Float = 0.0

        for index in 0..<frameLength {

            let sample = channel[index]

            sum += sample * sample
        }

        let rms = sqrt(
            sum / Float(frameLength)
        )

        guard rms > 0 else {
            return 0.0
        }

        let db = 20.0 * log10(
            Double(rms)
        )

        let minDb = -60.0
        let maxDb = 0.0

        let normalized =
            (db - minDb) /
            (maxDb - minDb)

        return min(
            max(normalized, 0.0),
            1.0
        )
    }
}
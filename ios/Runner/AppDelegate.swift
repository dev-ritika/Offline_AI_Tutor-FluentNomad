import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {


    private let transcriptStreamHandler =
    TranscriptStreamHandler()

    private lazy var whisperPlugin =
    WhisperPlugin(
        transcriptStreamHandler:
            transcriptStreamHandler
    )

   

    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {

     print("Handler:", ObjectIdentifier(transcriptStreamHandler))

    GeneratedPluginRegistrant.register(with: self)

    let controller = window!.rootViewController as! FlutterViewController

    let whisperChannel = FlutterMethodChannel(
        name: "whisper_transcribe",
        binaryMessenger: controller.binaryMessenger
    )

    let progressChannel = FlutterEventChannel(
        name: "whisper_progress",
        binaryMessenger: controller.binaryMessenger
    )

    let transcriptChannel = FlutterEventChannel(
    name: "whisper_transcript",
    binaryMessenger: controller.binaryMessenger
)

    progressChannel.setStreamHandler(
        whisperPlugin.progressStreamHandler
    )

    transcriptChannel.setStreamHandler(
    transcriptStreamHandler
)

    whisperChannel.setMethodCallHandler { [weak self] call, result in
        self?.whisperPlugin.handle(call, result: result)
    }

    return super.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
    )
}

    
}
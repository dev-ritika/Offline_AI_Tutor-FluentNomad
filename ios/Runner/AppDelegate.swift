import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

    private let whisperPlugin = WhisperPlugin()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        GeneratedPluginRegistrant.register(with: self)

        let controller = window!.rootViewController as! FlutterViewController

        let whisperChannel = FlutterMethodChannel(
            name: "whisper_transcribe",
            binaryMessenger: controller.binaryMessenger
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
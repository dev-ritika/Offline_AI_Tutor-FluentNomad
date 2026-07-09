import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = window?.rootViewController as! FlutterViewController

    let whisperChannel = FlutterMethodChannel(
        name: "whisper_transcribe",
        binaryMessenger: controller.binaryMessenger
    )

    let whisperPlugin = WhisperPlugin()

    whisperChannel.setMethodCallHandler { call, result in
        whisperPlugin.handle(call, result: result)
    }


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

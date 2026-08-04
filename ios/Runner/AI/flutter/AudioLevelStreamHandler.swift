import Flutter

final class AudioLevelStreamHandler: NSObject, FlutterStreamHandler {

    var eventSink: FlutterEventSink?

    func onListen(
        withArguments arguments: Any?,
        eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {

        print("🎤 Flutter started listening for audio levels")

        eventSink = events

        return nil
    }

    func onCancel(
        withArguments arguments: Any?
    ) -> FlutterError? {

        print("🎤 Flutter stopped listening for audio levels")

        eventSink = nil

        return nil
    }
}
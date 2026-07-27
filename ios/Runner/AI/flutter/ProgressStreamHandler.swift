import Flutter
import Foundation

final class ProgressStreamHandler: NSObject, FlutterStreamHandler {

    var eventSink: FlutterEventSink?

    func onListen(
        withArguments arguments: Any?,
        eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {

        eventSink = events

        return nil
    }

    func onCancel(
        withArguments arguments: Any?
    ) -> FlutterError? {

        eventSink = nil

        return nil
    }
}
class TranscriptStreamHandler:
    NSObject,
    FlutterStreamHandler {

    var eventSink: FlutterEventSink?


    func onListen(
        withArguments arguments: Any?,
        eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {

        print("🔥 Flutter started listening")

        self.eventSink = events

        return nil
    }


    func onCancel(
        withArguments arguments: Any?
    ) -> FlutterError? {

        self.eventSink = nil

        return nil
    }
}
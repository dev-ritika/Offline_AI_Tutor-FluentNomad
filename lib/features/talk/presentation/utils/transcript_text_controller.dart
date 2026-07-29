import 'dart:async';

class TranscriptTextController {
  final StreamController<String> _controller = StreamController.broadcast();

  Stream<String> get stream => _controller.stream;

  Timer? _timer;

  String _displayText = "";

  void addWhisperText(String text) {
    _timer?.cancel();

    _displayText = "";

    int index = 0;

    _timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (index >= text.length) {
        timer.cancel();

        return;
      }

      _displayText += text[index];

      index++;

      _controller.add(_displayText);
    });
  }

  void dispose() {
    _timer?.cancel();

    _controller.close();
  }
}

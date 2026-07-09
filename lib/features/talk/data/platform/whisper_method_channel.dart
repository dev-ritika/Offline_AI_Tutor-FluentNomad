import 'package:flutter/services.dart';

class WhisperMethodChannel {
  static const MethodChannel _whisperChannel = MethodChannel(
    "whisper_transcribe",
  );

  Future<String> getText({
    required String modelPath,
    required String audioPath,
    required String language,
  }) async {
    String text = await _whisperChannel.invokeMethod("getTranscriptedText", {
      'modelPath': modelPath,
      'audioPath': audioPath,
      'language': language,
    });

    print("check $text");
    return text;
  }
}

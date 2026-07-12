import 'package:flutter/services.dart';

class WhisperMethodChannel {
  static const MethodChannel _whisperChannel = MethodChannel(
    "whisper_transcribe",
  );

  Future<void> loadModel(String path) async {
    await _whisperChannel.invokeMethod('loadModel', {'path': path});

    final bool loaded =
        await _whisperChannel.invokeMethod<bool>("isModelLoaded") ?? false;

    print("Loaded = $loaded");
  }
}

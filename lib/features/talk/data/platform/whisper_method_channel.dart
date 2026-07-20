import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
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

  Future<String?> convertAudio(String audioPath) async {
    return await _whisperChannel.invokeMethod<String>("convertAudio", {
      "path": audioPath,
    });
  }

  Future<String> transcribe(String audioPath) async {
    final String text = await _whisperChannel.invokeMethod("transcribe", {
      "audioPath": audioPath,
    });

    print("called transcribe $text");

    return text;
  }
}

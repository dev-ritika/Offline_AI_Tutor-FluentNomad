import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WhisperMethodChannel {
  static const MethodChannel _whisperChannel = MethodChannel(
    "whisper_transcribe",
  );

  static const EventChannel _progressChannel = EventChannel("whisper_progress");

  static const EventChannel _transcriptChannel = EventChannel(
    "whisper_transcript",
  );

  static const EventChannel _audioLevelChannel = EventChannel(
    "audio_level_stream",
  );

  late final Stream<String> transcriptStream = _transcriptChannel
      .receiveBroadcastStream()
      .map((event) {
        return event.toString();
      });

  Stream<int> progressStream() {
    return _progressChannel.receiveBroadcastStream().cast<int>();
  }

  Stream<double> audioLevelStream() {
    return _audioLevelChannel.receiveBroadcastStream().map(
      (event) => (event as num).toDouble(),
    );
  }

  Future<void> cancel() async {
    await _whisperChannel.invokeMethod("cancel");
  }

  Future<void> startAudioLevel() async {
    await _whisperChannel.invokeMethod("startAudioLevel");
  }

  Future<void> stopAudioLevel() async {
    await _whisperChannel.invokeMethod("stopAudioLevel");
  }

  Future<void> loadModel(String path) async {
    await _whisperChannel.invokeMethod('loadModel', {'path': path});

    await _whisperChannel.invokeMethod<bool>("isModelLoaded") ?? false;
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

    return text;
  }
}

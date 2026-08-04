import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';

abstract interface class TranscribeAudioDataSource {
  Future<String?> convertAudio(String audioPath);

  Future<String> transcribeAudio(String audioPath);

  Stream<int> transcriptionProgressStream();

  Stream<double> audioLevelStream();
  Future<void> startAudioLevelStream();
  Future<void> stopAudioLevelStream();

  Future<void> cancelTranscription();

  Stream<String> get transcriptionAudioStream;
}

@LazySingleton(as: TranscribeAudioDataSource)
class TranscribeAudioDataSourceImpl implements TranscribeAudioDataSource {
  final WhisperMethodChannel whisperMethodChannel;

  const TranscribeAudioDataSourceImpl({required this.whisperMethodChannel});

  @override
  Future<String?> convertAudio(String audioPath) async {
    return await whisperMethodChannel.convertAudio(audioPath);
  }

  @override
  Future<String> transcribeAudio(String audioPath) async {
    return await whisperMethodChannel.transcribe(audioPath);
  }

  @override
  Stream<int> transcriptionProgressStream() {
    return whisperMethodChannel.progressStream();
  }

  @override
  Future<void> cancelTranscription() async {
    await whisperMethodChannel.cancel();
  }

  @override
  Stream<String> get transcriptionAudioStream {
    return whisperMethodChannel.transcriptStream;
  }

  @override
  Stream<double> audioLevelStream() {
    return whisperMethodChannel.audioLevelStream();
  }

  @override
  Future<void> startAudioLevelStream() {
    return whisperMethodChannel.startAudioLevel();
  }

  @override
  Future<void> stopAudioLevelStream() {
    return whisperMethodChannel.stopAudioLevel();
  }
}

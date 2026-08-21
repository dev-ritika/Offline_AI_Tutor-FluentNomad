import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/record_learn/data/platform/whisper_method_channel.dart';

abstract interface class TranscribeAudioDataSource {
  Future<String?> convertAudio(String audioPath);

  Future<String> transcribeAudio(String audioPath);

  Stream<int> transcriptionProgressStream();

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
}

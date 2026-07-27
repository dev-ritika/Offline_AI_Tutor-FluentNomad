import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';

abstract interface class TranscribeAudioDataSource {
  Future<String?> convertAudio(String audioPath);

  Future<String> transcribeAudio(String audioPath);
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
}

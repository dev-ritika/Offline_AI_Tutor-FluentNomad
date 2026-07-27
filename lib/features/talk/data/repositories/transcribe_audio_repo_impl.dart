import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/data/data_source/transcribe_audio_data_source.dart';
import 'package:offline_ai_tutor/features/talk/domain/repositories/transcribe_audio_repository.dart';

@LazySingleton(as: TranscribeAudioRepository)
class TranscribeAudioRepositoryImpl implements TranscribeAudioRepository {
  final TranscribeAudioDataSource transcribeAudioDataSource;

  const TranscribeAudioRepositoryImpl({
    required this.transcribeAudioDataSource,
  });

  @override
  Future<String?> convertAudio(String audioPath) async {
    return await transcribeAudioDataSource.convertAudio(audioPath);
  }

  @override
  Future<String> transcribeAudio(String audioPath) async {
    return await transcribeAudioDataSource.transcribeAudio(audioPath);
  }

  @override
  Stream<int> transcriptionProgressStream() {
    return transcribeAudioDataSource.transcriptionProgressStream();
  }
}

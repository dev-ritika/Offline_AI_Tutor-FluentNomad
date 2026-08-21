import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/transcribe_audio_repository.dart';

@lazySingleton
class ConvertAudio {
  final TranscribeAudioRepository transcribeAudioRepository;

  const ConvertAudio({required this.transcribeAudioRepository});

  Future<String?> call(String audioPath) async {
    return await transcribeAudioRepository.convertAudio(audioPath);
  }
}

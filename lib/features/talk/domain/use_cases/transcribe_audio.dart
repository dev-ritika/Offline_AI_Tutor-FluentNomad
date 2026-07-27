import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/domain/repositories/transcribe_audio_repository.dart';

@lazySingleton
class TranscribeAudio {
  final TranscribeAudioRepository transcribeAudioRepository;

  const TranscribeAudio({required this.transcribeAudioRepository});

  Future<String?> call(String audioPath) async {
    return await transcribeAudioRepository.transcribeAudio(audioPath);
  }
}

import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/domain/repositories/transcribe_audio_repository.dart';

@lazySingleton
class CancelTranscription {
  final TranscribeAudioRepository transcribeAudioRepository;

  const CancelTranscription({required this.transcribeAudioRepository});

  Future<void> call() async {
    await transcribeAudioRepository.cancelTranscription();
  }
}

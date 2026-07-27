import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/domain/repositories/transcribe_audio_repository.dart';

@injectable
class TranscriptionProgressStream {
  final TranscribeAudioRepository transcribeAudioRepository;
  const TranscriptionProgressStream({required this.transcribeAudioRepository});

  Stream<int> call() {
    return transcribeAudioRepository.transcriptionProgressStream();
  }
}

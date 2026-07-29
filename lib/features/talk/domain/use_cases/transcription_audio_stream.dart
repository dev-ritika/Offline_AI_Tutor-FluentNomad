import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/domain/repositories/transcribe_audio_repository.dart';

@lazySingleton
class TranscriptionAudioStream {
  final TranscribeAudioRepository transcribeAudioRepository;

  const TranscriptionAudioStream({required this.transcribeAudioRepository});

  Stream<String> get getStream {
    return transcribeAudioRepository.transcriptionAudioStream;
  }
}

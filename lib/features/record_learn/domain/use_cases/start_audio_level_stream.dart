import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/audio_level_repository.dart';

@lazySingleton
class StartAudioLevelStream {
  final AudioLevelRepository audioLevelRepository;

  const StartAudioLevelStream({required this.audioLevelRepository});

  Future<void> call() {
    return audioLevelRepository.startAudioLevelStream();
  }
}

import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/audio_level_repository.dart';

@lazySingleton
class StopAudioLevelStream {
  final AudioLevelRepository audioLevelRepository;

  const StopAudioLevelStream({required this.audioLevelRepository});

  Future<void> call() {
    return audioLevelRepository.stopAudioLevelStream();
  }
}

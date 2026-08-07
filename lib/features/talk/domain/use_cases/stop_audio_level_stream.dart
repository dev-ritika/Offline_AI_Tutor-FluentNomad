import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/domain/repositories/audio_level_repository.dart';

@lazySingleton
class StopAudioLevelStream {
  final AudioLevelRepository audioLevelRepository;

  const StopAudioLevelStream({required this.audioLevelRepository});

  Future<void> call() {
    return audioLevelRepository.stopAudioLevelStream();
  }
}

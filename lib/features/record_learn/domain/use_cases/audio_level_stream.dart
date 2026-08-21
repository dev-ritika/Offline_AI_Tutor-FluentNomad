import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/audio_level_repository.dart';

@lazySingleton
class AudioLevelStream {
  final AudioLevelRepository audioLevelRepository;

  const AudioLevelStream({required this.audioLevelRepository});

  Stream<double> call() {
    return audioLevelRepository.audioLevelStream();
  }
}

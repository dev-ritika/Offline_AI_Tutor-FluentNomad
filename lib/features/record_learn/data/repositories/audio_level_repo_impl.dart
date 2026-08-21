import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/record_learn/data/data_source/audio_level_data_source.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/audio_level_repository.dart';

@LazySingleton(as: AudioLevelRepository)
class AudioLevelRepoImpl implements AudioLevelRepository {
  final AudioLevelDataSource audioLevelDataSource;

  const AudioLevelRepoImpl({required this.audioLevelDataSource});

  @override
  Stream<double> audioLevelStream() {
    return audioLevelDataSource.audioLevelStream();
  }

  @override
  Future<void> startAudioLevelStream() {
    return audioLevelDataSource.startAudioLevelStream();
  }

  @override
  Future<void> stopAudioLevelStream() {
    return audioLevelDataSource.stopAudioLevelStream();
  }
}

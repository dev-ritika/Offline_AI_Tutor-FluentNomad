import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';

abstract interface class AudioLevelDataSource {
  Stream<double> audioLevelStream();
  Future<void> startAudioLevelStream();
  Future<void> stopAudioLevelStream();
}

@LazySingleton(as: AudioLevelDataSource)
class AudioLevelDataSourceImpl implements AudioLevelDataSource {
  final WhisperMethodChannel whisperMethodChannel;

  const AudioLevelDataSourceImpl({required this.whisperMethodChannel});

  @override
  Stream<double> audioLevelStream() {
    return whisperMethodChannel.audioLevelStream();
  }

  @override
  Future<void> startAudioLevelStream() {
    return whisperMethodChannel.startAudioLevel();
  }

  @override
  Future<void> stopAudioLevelStream() {
    return whisperMethodChannel.stopAudioLevel();
  }
}

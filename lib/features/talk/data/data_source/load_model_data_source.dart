import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';

abstract interface class LoadModelDataSource {
  Future<void> loadWhisperModel(String path);
}

@LazySingleton(as: LoadModelDataSource)
class LoadModelDataSourceImpl implements LoadModelDataSource {
  final WhisperMethodChannel whisperMethodChannel;

  const LoadModelDataSourceImpl({required this.whisperMethodChannel});

  @override
  Future<void> loadWhisperModel(String path) async {
    await whisperMethodChannel.loadModel(path);
  }
}

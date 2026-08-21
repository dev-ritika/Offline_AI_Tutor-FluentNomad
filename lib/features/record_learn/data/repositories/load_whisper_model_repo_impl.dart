import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/record_learn/data/data_source/load_model_data_source.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/load_whisper_model_repository.dart';

@LazySingleton(as: LoadWhisperModelRepository)
class LoadWhisperModelRepoImpl implements LoadWhisperModelRepository {
  final LoadModelDataSource loadModelDataSource;
  const LoadWhisperModelRepoImpl({required this.loadModelDataSource});

  @override
  Future<void> loadWhisperModel(String path) async {
    await loadModelDataSource.loadWhisperModel(path);
  }
}

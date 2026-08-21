import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/load_whisper_model_repository.dart';

@lazySingleton
class LoadWhisperModel {
  final LoadWhisperModelRepository loadWhisperModelRepository;

  const LoadWhisperModel({required this.loadWhisperModelRepository});

  Future<void> call(String path) async {
    await loadWhisperModelRepository.loadWhisperModel(path);
  }
}

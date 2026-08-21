import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/recording_repository.dart';

@lazySingleton
class StartRecording {
  final RecordingRepository recordingRepository;

  const StartRecording({required this.recordingRepository});

  Future<Either<Failures, void>> call() async {
    return await recordingRepository.startRecording();
  }
}

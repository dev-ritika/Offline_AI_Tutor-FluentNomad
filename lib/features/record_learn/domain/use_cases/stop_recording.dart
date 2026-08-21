import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/recording_repository.dart';

@lazySingleton
class StopRecording {
  final RecordingRepository recordingRepository;

  const StopRecording({required this.recordingRepository});

  Future<Either<Failures, String?>> call() async {
    return await recordingRepository.stopRecording();
  }
}

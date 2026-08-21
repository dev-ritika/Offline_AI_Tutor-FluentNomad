import 'package:dartz/dartz.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';

abstract interface class RecordingRepository {
  Future<Either<Failures, void>> startRecording();

  Future<Either<Failures, String?>> stopRecording();
}

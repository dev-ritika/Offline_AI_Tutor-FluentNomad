import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/talk/data/data_source/recording_data_source.dart';
import 'package:offline_ai_tutor/features/talk/domain/repositories/recording_repository.dart';

@LazySingleton(as: RecordingRepository)
class RecordingRepoImpl implements RecordingRepository {
  final RecordingDataSource recordingDataSource;

  RecordingRepoImpl({required this.recordingDataSource});

  @override
  Future<Either<Failures, void>> startRecording() async {
    final data = await recordingDataSource.startRecording();

    return data.fold((l) => left(AudioFailure(l.toString())), (r) {
      return right(null);
    });
  }

  @override
  Future<Either<Failures, String?>> stopRecording() async {
    final data = await recordingDataSource.stopRecording();

    return data.fold((l) => left(AudioFailure(l.toString())), (r) => right(r));
  }
}

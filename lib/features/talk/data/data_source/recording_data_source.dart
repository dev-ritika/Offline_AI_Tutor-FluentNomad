import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

abstract interface class RecordingDataSource {
  Future<Either<Exception, void>> startRecording();

  Future<Either<Exception, String?>> stopRecording();
}

@LazySingleton(as: RecordingDataSource)
class RecordingDataSourceImpl implements RecordingDataSource {
  final AudioRecorder recorder = AudioRecorder();

  @override
  Future<Either<Exception, void>> startRecording() async {
    try {
      final dir = await getTemporaryDirectory();

      final path = "${dir.path}/myFile.m4a";

      if (await recorder.hasPermission()) {
        await recorder.start(const RecordConfig(), path: path);
        return right(null);
      } else {
        return left(
          const AudioException(
            message:
                "Permission denied : audio cannot be recorded, go to the setting and allow the permisison to get started",
          ),
        );
      }
    } catch (e) {
      return left(const AudioException(message: "Something went wrong"));
    }
  }

  @override
  Future<Either<Exception, String?>> stopRecording() async {
    try {
      String? path;

      path = await recorder.stop();

      print("pathpath $path");

      if (path != null) {
        return right(path);
      } else {
        return left(const AudioException(message: "Something went wrong"));
      }
    } catch (e) {
      return left(const AudioException(message: "Something went wrong"));
    }
  }
}

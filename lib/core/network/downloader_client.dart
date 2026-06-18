import 'dart:async';
import 'dart:math';
import 'package:background_downloader/background_downloader.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/network/helpers/download_model.dart';

@lazySingleton
class DownloaderClient {
  Stream<Either<Exception, DownloadModel>> downloadFile({
    required String url,
    Map<String, dynamic>? queryParams,
    int maxRetries = 4,
  }) async* {
    for (var attempts = 1; attempts <= maxRetries; attempts++) {
      final StreamController progressController = StreamController<int>();

      try {
        //final dir = await getApplicationDocumentsDirectory();
        final fileName = url.split('/').last;
        // final savePath = '${dir.path}/$fileName';

        final DownloadTask task = DownloadTask(
          baseDirectory: BaseDirectory.applicationDocuments,
          directory: 'models',
          filename: fileName,
          retries: 1,
          url: url,
        );

        final data = FileDownloader()
            .download(
              task,
              onProgress: (progress) {
                if (progress >= 0 && progress <= 1) {
                  progressController.add((progress * 100).round());
                }
              },
            )
            .whenComplete(progressController.close);

        await for (var percentage in progressController.stream) {
          yield right(DownloadModel(download: percentage));
        }

        final TaskStatusUpdate status = await data;

        if (status.status == TaskStatus.complete) {
          return;
        }

        if (!_isRetryable(status)) {
          yield left(NetworkException(message: 'Download error - $e'));

          return;
        }

        if (attempts == maxRetries) {
          yield left(NetworkException(message: 'Download error - $e'));

          return;
        }

        final delay = _backoff(attempts);
        await Future.delayed(delay);
      } catch (e) {
        await progressController.close().catchError(
          (_) {},
        ); // ensure controller is closed
        if (attempts == maxRetries) {
          yield left(NetworkException(message: 'Download error - $e'));
          return;
        }
      }
    }
  }

  Duration _backoff(int attempt) =>
      Duration(seconds: 1 << (attempt - 1)) + // 1, 2, 4, 8s
      Duration(milliseconds: Random().nextInt(500));

  bool _isRetryable(TaskStatusUpdate update) {
    switch (update.status) {
      case TaskStatus.canceled:
      case TaskStatus.notFound: // 404 — permanent
        return false;
      case TaskStatus.failed:
        final code = update.responseStatusCode;
        if (code != null && code >= 400 && code < 500 && code != 429) {
          return false; // 4xx auth/bad-request — permanent
        }
        // package already retried transport; treat exhausted transport as terminal
        return false;
      default:
        return false;
    }
  }
}

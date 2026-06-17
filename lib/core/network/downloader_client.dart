import 'dart:async';
import 'package:background_downloader/background_downloader.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/network/helpers/download_model.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class DownloaderClient {
  Stream<Either<Exception, DownloadModel>> downloadFile({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async* {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = url.split('/').last;
      final savePath = '${dir.path}/$fileName';

      final StreamController progressController = StreamController<int>();

      final DownloadTask task = DownloadTask(url: url, directory: savePath);

      FileDownloader()
          .download(
            task,
            onProgress: (progress) {
              progressController.add((progress * 100).round());
            },
          )
          .then((TaskStatusUpdate update) {
            progressController.close();
          })
          .onError((e, s) {
            progressController.close();
          });

      await for (var percentage in progressController.stream) {
        yield right(DownloadModel(download: percentage));
      }
    } on DioException catch (e) {
      yield left(NetworkException(message: "Network error - ${e.message}"));
    } catch (e) {
      yield left(NetworkException(message: "Unknown error - ${e.toString()}"));
    }
  }
}

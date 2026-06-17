import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/core/network/downloader_client.dart';
import 'package:offline_ai_tutor/core/network/helpers/download_model.dart';

abstract interface class InstallModelDataSource {
  Stream<Either<Failures, DownloadModel>> installModels(String url);
}

@LazySingleton(as: InstallModelDataSource)
class InstallModelDataSourceImpl implements InstallModelDataSource {
  final DownloaderClient downloaderClient;

  InstallModelDataSourceImpl({required this.downloaderClient});

  @override
  Stream<Either<Failures, DownloadModel>> installModels(String url) async* {
    try {
      final response = downloaderClient.downloadFile(url: url);

      await for (var data in response) {
        yield data.fold(
          (l) => left(NetworkFailure(l.toString())),
          (r) => right(r),
        );
      }
    } on NetworkException catch (e) {
      yield left(NetworkFailure("Network failure - $e"));
    } catch (e) {
      yield left(NetworkFailure("Network failure - $e"));
    }
  }
}

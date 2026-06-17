import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class DioClient {
  //Note for me - singleton pattern is not really required since registered as lazySingleton
  late final Dio dio;

  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://dev-ritika.github.io/",
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.addAll([
      PrettyDioLogger(responseBody: true, requestBody: true),
    ]);
  }

  Future<Either<Exception, Response>> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final Response response = await dio.get(
        endpoint,
        queryParameters: queryParams,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return right(response);
      }

      return left(
        NetworkException(message: "Server error - ${response.statusMessage}"),
      );
    } on DioException catch (e) {
      return left(NetworkException(message: "Network error - ${e.message}"));
    } catch (e) {
      return left(NetworkException(message: "Unknown error - ${e.toString()}"));
    }
  }
}

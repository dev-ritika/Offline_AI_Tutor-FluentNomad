import 'package:dartz/dartz.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';

abstract interface class GetHomeDataRepository {
  Either<Failures, HomeData?> getHomeData();
}

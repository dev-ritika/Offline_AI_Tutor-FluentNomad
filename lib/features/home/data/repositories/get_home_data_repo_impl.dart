import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/home/data/data_model/home_data_model.dart';
import 'package:offline_ai_tutor/features/home/data/data_source/get_home_data_source.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/repositories/get_home_data_repository.dart';

@LazySingleton(as: GetHomeDataRepository)
class GetHomeDataRepoImpl implements GetHomeDataRepository {
  final GetHomeDataSource getHomeDataSource;

  const GetHomeDataRepoImpl({required this.getHomeDataSource});

  @override
  Either<Failures, HomeData?> getHomeData() {
    try {
      final Either<Exception, HomeDataModel?> homeData = getHomeDataSource
          .getHomeData();

      return homeData.fold(
        (l) {
          return left(CacheFailure(l.toString()));
        },
        (r) {
          final HomeData? homeData = r?.toDomain();
          return right(homeData);
        },
      );

      // final HomeData homeData = homeDataModel?.toDomain();
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}

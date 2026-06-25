import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_keys.dart';
import 'package:offline_ai_tutor/features/home/data/data_model/home_data_model.dart';

abstract interface class GetHomeDataSource {
  Either<Exception, HomeDataModel?> getHomeData();
}

@LazySingleton(as: GetHomeDataSource)
class GetHomeDataSourceImpl implements GetHomeDataSource {
  final Box<HomeDataModel> homeDataBox;

  const GetHomeDataSourceImpl({@Named("homeData") required this.homeDataBox});

  @override
  Either<Exception, HomeDataModel?> getHomeData() {
    try {
      final HomeDataModel? homeData = homeDataBox.get(HiveKeys.homeData);

      return right(homeData);
    } catch (e) {
      return left(HiveDataException(message: e.toString()));
    }
  }
}

import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_keys.dart';
import 'package:offline_ai_tutor/features/home/data/data_model/home_data_model.dart';

abstract interface class SaveHomeDataSource {
  Future<void> saveHomeData(HomeDataModel homeData);
}

@LazySingleton(as: SaveHomeDataSource)
class SaveHomeDataSourceImpl extends SaveHomeDataSource {
  final Box<HomeDataModel> homeDataBox;

  SaveHomeDataSourceImpl({@Named("homeData") required this.homeDataBox});

  @override
  Future<void> saveHomeData(HomeDataModel homeData) async {
    await homeDataBox.put(HiveKeys.homeData, homeData);
  }
}

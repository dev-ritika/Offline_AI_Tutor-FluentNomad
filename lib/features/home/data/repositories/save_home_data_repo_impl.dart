import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/home/data/data_model/home_data_model.dart';
import 'package:offline_ai_tutor/features/home/data/data_source/save_home_data_source.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/repositories/save_home_data_repository.dart';

@LazySingleton(as: SaveHomeDataRepository)
class SaveHomeDataRepoImpl implements SaveHomeDataRepository {
  final SaveHomeDataSource saveHomeDataSource;

  const SaveHomeDataRepoImpl({required this.saveHomeDataSource});

  @override
  Future<void> saveHomeData(HomeData data) async {
    final HomeDataModel homeData = HomeDataModel.fromDomain(data);

    await saveHomeDataSource.saveHomeData(homeData);
  }
}

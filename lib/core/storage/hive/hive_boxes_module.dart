import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_boxes_names.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/user_data_model.dart';

@module
abstract class HiveBoxesModule {
  @Named("userPrefs")
  @lazySingleton
  Box<UserDataModel> get getUserPrefBox =>
      Hive.box<UserDataModel>(HiveBoxesNames.userPrefsBox);

  @Named("modelsInstall")
  @lazySingleton
  Box<List> get getModelsInstallBox =>
      Hive.box<List>(HiveBoxesNames.modeslInstallBox);
}

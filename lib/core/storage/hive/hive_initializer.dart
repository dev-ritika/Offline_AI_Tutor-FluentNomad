import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_boxes_names.dart';
import 'package:offline_ai_tutor/features/home/data/data_model/home_data_model.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/language_model.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/level_data_model.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/llm_model_install.dart';
import 'package:offline_ai_tutor/features/user/data/data_model/user_data_model.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_enum.dart';

abstract interface class HiveInitializer {
  Future<void> init();
}

@LazySingleton(as: HiveInitializer)
class HiveInitializerImpl implements HiveInitializer {
  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(UserDataModelAdapter())
      ..registerAdapter(LanguageModelAdapter())
      ..registerAdapter(LevelDataModelAdapter())
      ..registerAdapter(LlmModelInstallAdapter())
      ..registerAdapter(HomeDataModelAdapter())
      ..registerAdapter(ModelInstallStatusAdapter());

    // await Hive.deleteBoxFromDisk(HiveBoxesNames.modeslInstallBox);
    //await Hive.deleteBoxFromDisk(HiveBoxesNames.homeDataBox);
    // await Hive.deleteBoxFromDisk(HiveBoxesNames.userPrefsBox);

    await Future.wait([
      Hive.openBox<UserDataModel>(HiveBoxesNames.userPrefsBox),
      Hive.openBox<List>(HiveBoxesNames.modeslInstallBox),
      Hive.openBox<HomeDataModel>(HiveBoxesNames.homeDataBox),
    ]);
  }
}

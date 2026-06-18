import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_boxes_names.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/language_model.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/level_data_model.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/llm_model_install.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/user_data_model.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/model_install_status_enum.dart';

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
      ..registerAdapter(ModelInstallStatusAdapter());

    // await Hive.deleteBoxFromDisk(HiveBoxesNames.modeslInstallBox);
    // await Hive.deleteBoxFromDisk(HiveBoxesNames.userPrefsBox);

    await Future.wait([
      Hive.openBox<UserDataModel>(HiveBoxesNames.userPrefsBox),
      Hive.openBox<List>(HiveBoxesNames.modeslInstallBox),
    ]);
  }
}

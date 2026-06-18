import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_keys.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/llm_model_install.dart';

abstract interface class SaveModelsInstallStatusSource {
  Future<Either<Exception, bool>> saveModelsInstallStatus(
    List<LlmModelInstall> data,
  );
}

@LazySingleton(as: SaveModelsInstallStatusSource)
class SaveModelsInstallStatusSourceImpl
    implements SaveModelsInstallStatusSource {
  final Box<List> installStatusBox;

  SaveModelsInstallStatusSourceImpl({
    @Named("modelsInstall") required this.installStatusBox,
  });

  @override
  Future<Either<Exception, bool>> saveModelsInstallStatus(
    List<LlmModelInstall> installData,
  ) async {
    try {
      await installStatusBox.put(HiveKeys.modelInstallStatus, installData);

      return right(true);
    } catch (e) {
      return left(HiveDataException(message: "Exception"));
    }
  }
}

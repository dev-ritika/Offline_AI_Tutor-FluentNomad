import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/llm_model_install.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/save_models_install_status_source.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_data.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/save_model_install_status_repository.dart';

@LazySingleton(as: SaveModelInstallStatusrepository)
class SaveModelInstallStatusRepositoryImpl
    implements SaveModelInstallStatusrepository {
  final SaveModelsInstallStatusSource saveModelsInstallStatusSource;

  const SaveModelInstallStatusRepositoryImpl({
    required this.saveModelsInstallStatusSource,
  });

  @override
  Future<Either<Failures, bool>> saveModelsInstallStatus(
    List<ModelInstallData> data,
  ) async {
    try {
      final List<LlmModelInstall> modelData = data
          .map((e) => LlmModelInstall.fromDomain(e))
          .toList();

      await saveModelsInstallStatusSource.saveModelsInstallStatus(modelData);

      return right(true);
    } on HiveDataException catch (e) {
      return left(CacheFailure("Netowork failue ${e.message}"));
    } catch (e) {
      return left(CacheFailure("Netowork failue ${e.toString()}"));
    }
  }
}

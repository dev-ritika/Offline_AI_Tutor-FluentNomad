import 'package:dartz/dartz.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_keys.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/llm_model_install.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/user_data_model.dart';

abstract interface class GetModelInstallStatusSource {
  Either<Exception, ({List<LlmModelInstall> modelData, bool userData})>
  getModelInstallStatus();
}

@LazySingleton(as: GetModelInstallStatusSource)
class GetModelInstallStatusSourceImpl implements GetModelInstallStatusSource {
  final Box<List> installStatusBox;
  final Box<UserDataModel> userPrefBox;

  const GetModelInstallStatusSourceImpl({
    @Named("modelsInstall") required this.installStatusBox,
    @Named("userPrefs") required this.userPrefBox,
  });

  @override
  Either<Exception, ({List<LlmModelInstall> modelData, bool userData})>
  getModelInstallStatus() {
    try {
      final List<LlmModelInstall> data =
          installStatusBox
              .get(HiveKeys.modelInstallStatus)
              ?.cast<LlmModelInstall>() ??
          [];

      bool userDataAdded = false;
      final UserDataModel? userData = userPrefBox.get(HiveKeys.userDataKey);

      print("userData $userData");

      print("model data $data");

      if (userData == null) {
        userDataAdded = false;
      } else {
        userDataAdded = true;
      }

      return right((modelData: data, userData: userDataAdded));
    } catch (e) {
      return left(HiveDataException(message: "Exception"));
    }
  }
}

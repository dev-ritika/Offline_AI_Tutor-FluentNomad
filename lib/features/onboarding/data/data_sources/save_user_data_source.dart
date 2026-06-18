import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_keys.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/user_data_model.dart';

abstract interface class SaveUserDataLocallyDataSource {
  Future<void> saveLanguage(UserDataModel selectedLanguage);
}

@LazySingleton(as: SaveUserDataLocallyDataSource)
class SaveUserDataLocallyDataSourceImpl
    implements SaveUserDataLocallyDataSource {
  final Box<UserDataModel> userPrefBox;

  SaveUserDataLocallyDataSourceImpl(@Named("userPrefs") this.userPrefBox);

  @override
  Future<void> saveLanguage(UserDataModel userData) async {
    try {
      await userPrefBox.put(HiveKeys.userDataKey, userData);
    } catch (e) {
      throw HiveDataException(message: "Something went wrong");
    }
  }
}

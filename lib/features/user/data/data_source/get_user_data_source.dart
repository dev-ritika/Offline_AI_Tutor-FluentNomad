import 'package:dartz/dartz.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_keys.dart';
import 'package:offline_ai_tutor/features/user/data/data_model/user_data_model.dart';

abstract interface class GetUserDataSource {
  Either<Exception, UserDataModel?> getUserData();
}

@LazySingleton(as: GetUserDataSource)
class GetUserDataSourceImpl implements GetUserDataSource {
  final Box<UserDataModel> userPrefBox;

  const GetUserDataSourceImpl({@Named('userPrefs') required this.userPrefBox});

  @override
  Either<Exception, UserDataModel?> getUserData() {
    try {
      final UserDataModel? userData = userPrefBox.get(HiveKeys.userDataKey);

      return right(userData);
    } catch (e) {
      return left(HiveDataException(message: e.toString()));
    }
  }
}

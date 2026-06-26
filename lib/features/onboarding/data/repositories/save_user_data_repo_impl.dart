import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/exceptions.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/user/data/data_model/user_data_model.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/save_user_data_source.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/save_user_data_repository.dart';

@LazySingleton(as: SaveUserDataRepository)
class SaveUserDataRepoImpl implements SaveUserDataRepository {
  final SaveUserDataLocallyDataSource saveUserDataLocallyDataSource;

  const SaveUserDataRepoImpl({required this.saveUserDataLocallyDataSource});

  @override
  Future<Either<Failures, void>> saveUserData(UserData userData) async {
    try {
      final UserDataModel userDataModel = UserDataModel.fromDomain(userData);

      await saveUserDataLocallyDataSource.saveLanguage(userDataModel);

      return const Right(null);
    } on HiveDataException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}

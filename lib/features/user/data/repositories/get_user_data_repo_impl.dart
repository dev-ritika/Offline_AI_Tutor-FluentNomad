import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/user/data/data_model/user_data_model.dart';
import 'package:offline_ai_tutor/features/user/data/data_source/get_user_data_source.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/user/domain/repositories/get_user_data_repository.dart';

@LazySingleton(as: GetUserDataRepository)
class GetUserDataRepoImpl implements GetUserDataRepository {
  final GetUserDataSource getUserDataSource;

  const GetUserDataRepoImpl({required this.getUserDataSource});

  @override
  Either<Failures, UserData?> getUserData() {
    final Either<Exception, UserDataModel?> data = getUserDataSource
        .getUserData();

    return data.fold(
      (l) {
        return left(CacheFailure(l.toString()));
      },
      (r) {
        final UserData? userData = r?.toDomain();

        return right(userData);
      },
    );
  }
}

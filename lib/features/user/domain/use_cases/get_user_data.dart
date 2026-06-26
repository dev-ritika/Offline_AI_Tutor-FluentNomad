import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/user/domain/repositories/get_user_data_repository.dart';

@lazySingleton
class GetUserData {
  final GetUserDataRepository getUserDataRepository;

  const GetUserData({required this.getUserDataRepository});

  Either<Failures, UserData?> call() {
    return getUserDataRepository.getUserData();
  }
}

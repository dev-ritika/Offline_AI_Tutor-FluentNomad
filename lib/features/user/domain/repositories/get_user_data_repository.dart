import 'package:dartz/dartz.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';

abstract interface class GetUserDataRepository {
  Either<Failures, UserData?> getUserData();
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/save_user_data_repository.dart';

@lazySingleton
class SaveUserData {
  final SaveUserDataRepository saveUserDataRepo;

  SaveUserData({required this.saveUserDataRepo});

  Future<Either<Failures, void>> call(UserData params) async {
    final data = await saveUserDataRepo.saveUserData(params);

    return data;
  }
}

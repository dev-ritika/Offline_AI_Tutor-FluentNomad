import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_data.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/get_model_install_status_repository.dart';

@lazySingleton
class GetModelInstallStatus {
  final GetModelInstallStatusRepository getModelInstallStatusRepository;

  const GetModelInstallStatus({required this.getModelInstallStatusRepository});

  Either<Failures, ({List<ModelInstallData> modelData, UserData? userData})>
  call() {
    return getModelInstallStatusRepository.getModelInstallStatus();
  }
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/repositories/get_home_data_repository.dart';

@lazySingleton
class GetHomeData {
  final GetHomeDataRepository getHomeDataRepository;

  const GetHomeData({required this.getHomeDataRepository});

  Either<Failures, HomeData?> call() {
    return getHomeDataRepository.getHomeData();
  }
}

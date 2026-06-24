import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/repositories/save_home_data_repository.dart';

@lazySingleton
class SaveHomeData {
  final SaveHomeDataRepository saveHomeDataRepository;

  const SaveHomeData({required this.saveHomeDataRepository});

  Future<void> call(HomeData data) async {
    await saveHomeDataRepository.saveHomeData(data);
  }
}

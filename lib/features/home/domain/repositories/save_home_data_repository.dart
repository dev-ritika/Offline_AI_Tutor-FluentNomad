import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';

abstract interface class SaveHomeDataRepository {
  Future<void> saveHomeData(HomeData data);
}

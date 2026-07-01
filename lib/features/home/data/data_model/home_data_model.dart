import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_type_ids.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';
part 'home_data_model.g.dart';

@HiveType(typeId: HiveTypeIds.homeDataId)
class HomeDataModel {
  @HiveField(0)
  final int streakDays;

  @HiveField(1)
  final int? elapsedTimeToday;

  @HiveField(2)
  final DateTime? lastCompletedDate;

  HomeDataModel({
    required this.streakDays,
    required this.elapsedTimeToday,
    required this.lastCompletedDate,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> data) {
    return HomeDataModel(
      streakDays: data['streakDays'],
      elapsedTimeToday: data['elapsedTimeToday'],
      lastCompletedDate: data['lastCompletedDate'],
    );
  }

  Map<String, dynamic> toJson(HomeDataModel data) {
    return {
      "streakDays": data.streakDays,
      "elapsedTimeToday": data.elapsedTimeToday,
      "lastCompletedDate": data.lastCompletedDate,
    };
  }

  HomeData toDomain() {
    return HomeData(
      streakDays: streakDays,
      elapsedTimeToday: elapsedTimeToday,
      lastCompletedDate: lastCompletedDate,
    );
  }

  factory HomeDataModel.fromDomain(HomeData data) {
    return HomeDataModel(
      streakDays: data.streakDays,
      elapsedTimeToday: data.elapsedTimeToday,
      lastCompletedDate: data.lastCompletedDate,
    );
  }
}

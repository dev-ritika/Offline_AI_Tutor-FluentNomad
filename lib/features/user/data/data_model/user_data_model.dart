import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_type_ids.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/language_model.dart';
import 'package:offline_ai_tutor/features/onboarding/data/data_model/level_data_model.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
part 'user_data_model.g.dart';

@HiveType(typeId: HiveTypeIds.userDataModelId)
class UserDataModel {
  @HiveField(0)
  final LanguageModel selectedLanguage;

  @HiveField(1)
  final LevelDataModel selectedLevel;

  @HiveField(2)
  final String userName;

  const UserDataModel({
    required this.selectedLanguage,
    required this.selectedLevel,
    required this.userName,
  });

  // factory UserDataModel.fromJson(Map<String, dynamic> json) {
  //   return UserDataModel(
  //     selectedLanguage: json["selectedLanguage"],
  //     selectedLevel: json['selectedLevel'],
  //     userName: json['userName'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "selectedLanguage": selectedLanguage,
  //     "selectedLevel": selectedLevel,
  //     "userName": userName,
  //   };
  // }

  UserData toDomain() {
    return UserData(
      selectedLanguage: selectedLanguage.toDomain(),
      selectedLevel: selectedLevel.toDomain(),
      userName: userName,
    );
  }

  factory UserDataModel.fromDomain(UserData data) {
    return UserDataModel(
      selectedLanguage: LanguageModel.fromDomain(data.selectedLanguage),
      selectedLevel: LevelDataModel.fromDomain(data.selectedLevel),
      userName: data.userName,
    );
  }
}

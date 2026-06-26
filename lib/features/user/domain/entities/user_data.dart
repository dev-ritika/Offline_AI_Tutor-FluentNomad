import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/language.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/level.dart';

class UserData extends Equatable {
  final Language selectedLanguage;
  final Level selectedLevel;
  final String userName;

  const UserData({
    required this.selectedLanguage,
    required this.selectedLevel,
    required this.userName,
  });

  @override
  List<Object?> get props => [selectedLanguage, selectedLevel, userName];
}

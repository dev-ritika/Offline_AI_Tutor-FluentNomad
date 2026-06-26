import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/core/utils/enums/state_enum.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';

class HomeDataState extends Equatable {
  final int streakDays;
  final StateStatusEnum stateStatus;
  final int elapsedTime;
  final UserData? userData;

  const HomeDataState({
    required this.streakDays,
    required this.stateStatus,
    required this.elapsedTime,
    this.userData,
  });

  HomeDataState copyWith({
    int? streakDays,
    StateStatusEnum? stateStatus,
    int? elapsedTime,
    UserData? userData,
  }) {
    return HomeDataState(
      streakDays: streakDays ?? this.streakDays,
      stateStatus: stateStatus ?? this.stateStatus,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [streakDays, stateStatus, elapsedTime, userData];
}

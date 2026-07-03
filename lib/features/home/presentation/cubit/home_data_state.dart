import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/core/utils/enums/state_enum.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';

class HomeDataState extends Equatable {
  final int streakDays;
  final StateStatusEnum stateStatus;
  final int elapsedTime;
  final DateTime? lastCompletedDate;

  const HomeDataState({
    required this.streakDays,
    required this.stateStatus,
    required this.elapsedTime,
    this.lastCompletedDate,
  });

  HomeDataState copyWith({
    int? streakDays,
    StateStatusEnum? stateStatus,
    int? elapsedTime,
    UserData? userData,
    DateTime? lastCompletedDate,
  }) {
    return HomeDataState(
      streakDays: streakDays ?? this.streakDays,
      stateStatus: stateStatus ?? this.stateStatus,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
    );
  }

  @override
  List<Object?> get props => [
    streakDays,
    stateStatus,
    elapsedTime,
    lastCompletedDate,
  ];
}

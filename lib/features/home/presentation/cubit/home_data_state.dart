import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/core/utils/enums/state_enum.dart';

class HomeDataState extends Equatable {
  final int streakDays;
  final StateStatusEnum stateStatus;
  final int elapsedTime;

  const HomeDataState({
    required this.streakDays,
    required this.stateStatus,
    required this.elapsedTime,
  });

  HomeDataState copyWith({
    int? streakDays,
    StateStatusEnum? stateStatus,
    int? elapsedTime,
  }) {
    return HomeDataState(
      streakDays: streakDays ?? this.streakDays,
      stateStatus: stateStatus ?? this.stateStatus,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }

  @override
  List<Object?> get props => [streakDays, stateStatus, elapsedTime];
}

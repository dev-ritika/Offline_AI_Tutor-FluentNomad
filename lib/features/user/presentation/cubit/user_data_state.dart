import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';

class UserDataState extends Equatable {
  final UserData? userData;
  final Failures? failures;

  const UserDataState({this.userData, this.failures});

  UserDataState copyWith({UserData? userData, Failures? failures}) {
    return UserDataState(
      userData: userData ?? this.userData,
      failures: failures ?? this.failures,
    );
  }

  @override
  List<Object?> get props => [userData, failures];
}

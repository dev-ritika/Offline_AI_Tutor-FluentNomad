import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/user/domain/use_cases/get_user_data.dart';
import 'package:offline_ai_tutor/features/user/presentation/cubit/user_data_state.dart';

@injectable
class UserDataCubit extends Cubit<UserDataState> {
  final GetUserData getUserData;

  UserDataCubit({required this.getUserData}) : super(const UserDataState());

  void getUserLocalData() {
    final Either<Failures, UserData?> data = getUserData();

    data.fold(
      (l) {
        emit(state.copyWith(failures: l));
      },
      (r) {
        emit(state.copyWith(userData: r));
      },
    );
  }
}

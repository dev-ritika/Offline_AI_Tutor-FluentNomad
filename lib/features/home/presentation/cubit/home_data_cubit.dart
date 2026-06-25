import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/core/utils/enums/state_enum.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/use_cases/get_home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/use_cases/save_home_data.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_state.dart';

@injectable
class HomeDataCubit extends Cubit<HomeDataState> {
  final SaveHomeData saveData;
  final GetHomeData getData;
  HomeDataCubit({required this.saveData, required this.getData})
    : super(
        const HomeDataState(
          streakDays: 0,
          stateStatus: StateStatusEnum.empty,
          elapsedTime: 0,
        ),
      ) {
    getHomeData();
    saveHomeData();
  }

  late Timer timer;

  Future<void> saveHomeData() async {
    int time = 0;

    timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      time++;
      emit(state.copyWith(elapsedTime: time));

      if (time >= 30) {
        await saveData(HomeData(streakDays: state.streakDays + 1));
        emit(state.copyWith(streakDays: state.streakDays + 1));
        timer.cancel();
      }
    });
  }

  void getHomeData() {
    emit(state.copyWith(stateStatus: StateStatusEnum.loading));

    final Either<Failures, HomeData?> data = getData();

    data.fold(
      (l) {
        emit(state.copyWith(stateStatus: StateStatusEnum.error));
      },
      (r) {
        emit(
          state.copyWith(
            streakDays: r?.streakDays,
            stateStatus: StateStatusEnum.loaded,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    timer.cancel();
    return super.close();
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/core/utils/constants/global_consts.dart';
import 'package:offline_ai_tutor/core/utils/enums/state_enum.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/use_cases/get_home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/use_cases/save_home_data.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_state.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/user/domain/use_cases/get_user_data.dart';

@injectable
class HomeDataCubit extends Cubit<HomeDataState> with WidgetsBindingObserver {
  final SaveHomeData saveData;
  final GetHomeData getData;
  final GetUserData getUserData;
  HomeDataCubit({
    required this.saveData,
    required this.getData,
    required this.getUserData,
  }) : super(
         const HomeDataState(
           streakDays: 0,
           stateStatus: StateStatusEnum.empty,
           elapsedTime: 0,
         ),
       ) {
    WidgetsBinding.instance.addObserver(this);

    getHomeData();
    saveHomeData();
  }

  Timer? timer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      timer?.cancel();
    }
    if (state == AppLifecycleState.resumed) {
      saveHomeData();
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> saveHomeData() async {
    int time = state.elapsedTime;

    if (time >= GlobalConsts.kDailyGoalMinutes) return;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      time++;

      emit(state.copyWith(elapsedTime: time));

      await saveData(
        HomeData(
          streakDays: state.streakDays,
          elapsedTimeToday: time,
          lastCompletedDate: DateUtils.dateOnly(DateTime.now()),
        ),
      );

      if (time >= GlobalConsts.kDailyGoalMinutes) {
        await saveData(
          HomeData(
            streakDays: state.streakDays + 1,
            elapsedTimeToday: time,
            lastCompletedDate: DateUtils.dateOnly(DateTime.now()),
          ),
        );

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
            elapsedTime:
                r?.lastCompletedDate == DateUtils.dateOnly(DateTime.now())
                ? r?.elapsedTimeToday
                : 0,
          ),
        );
      },
    );
  }

  void getUserLocalData() {
    final Either<Failures, UserData?> data = getUserData();

    data.fold(
      (l) {
        emit(state.copyWith(stateStatus: StateStatusEnum.error));
      },
      (r) {
        emit(state.copyWith(userData: r));
      },
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}

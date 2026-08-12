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

@injectable
class HomeDataCubit extends Cubit<HomeDataState> with WidgetsBindingObserver {
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
    WidgetsBinding.instance.addObserver(this);
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
            lastGoalCompletedDate: r?.lastCompletedDate,
            lastActiveDate: r?.lastActiveDate,
            elapsedTime: DateUtils.isSameDay(r?.lastActiveDate!, DateTime.now())
                ? r?.elapsedTimeToday
                : 0,
          ),
        );
      },
    );
  }

  Future<void> saveHomeData() async {
    int time = state.elapsedTime;
    int streakDays = state.streakDays;

    print("last elaosed time ${time}");

    if (time >= GlobalConsts.kDailyGoalMinutes ||
        (state.lastGoalCompletedDate != null &&
            DateUtils.isSameDay(
              state.lastGoalCompletedDate ?? DateTime.now(),
              DateTime.now(),
            ))) {
      return;
    }

    if (DateUtils.dateOnly(DateTime.now()).difference(
          state.lastGoalCompletedDate ?? DateUtils.dateOnly(DateTime.now()),
        ) >
        const Duration(days: 1)) {
      streakDays = 0;
    }

    timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      time++;

      emit(state.copyWith(elapsedTime: time, streakDays: streakDays));

      await saveData(
        HomeData(
          streakDays: state.streakDays,
          elapsedTimeToday: time,
          lastActiveDate: DateUtils.dateOnly(DateTime.now()),
        ),
      );

      if (time >= GlobalConsts.kDailyGoalMinutes) {
        await saveData(
          HomeData(
            streakDays: state.streakDays + 1,
            elapsedTimeToday: time,
            lastCompletedDate: DateUtils.dateOnly(DateTime.now()),
            lastActiveDate: DateUtils.dateOnly(DateTime.now()),
          ),
        );

        emit(state.copyWith(streakDays: state.streakDays + 1));
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}

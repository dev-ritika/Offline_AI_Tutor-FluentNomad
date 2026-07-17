import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/start_recording.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/stop_recording.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_state.dart';

@injectable
class RecordingCubit extends Cubit<RecordingState> {
  final StartRecording startRecording;
  final StopRecording stopRecording;

  RecordingCubit({required this.startRecording, required this.stopRecording})
    : super(const RecordingState());

  Future<void> startAudioRecording() async {
    emit(state.copyWith(isRecording: true));

    final data = await startRecording();

    data.fold(
      (l) {
        emit(state.copyWith(isRecording: false, failure: l));
      },
      (r) {
        emit(state.copyWith(failure: null));
      },
    );
  }

  Future<void> stopAudioRecording() async {
    final data = await stopRecording();

    data.fold(
      (l) {
        emit(state.copyWith(isRecording: false, failure: l));
      },
      (r) {
        emit(state.copyWith(isRecording: false, audioPath: r));
      },
    );
  }

  Timer? _timer;
  Stopwatch stopwatch = Stopwatch();

  void startTimer() {
    String seconds;
    String minutes;
    String hours;
    String time;

    stopwatch.start();

    _timer = Timer.periodic(const Duration(seconds: 1), (tick) {
      seconds = (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
      minutes = (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0");
      hours = (stopwatch.elapsed.inHours).toString().padLeft(2, "0");

      time = "$hours : $minutes : $seconds";

      emit(state.copyWith(recordingTime: time));
    });
  }

  void stopTimer() {
    stopwatch.stop();
    stopwatch.reset();
    _timer?.cancel();
  }

  @override
  Future<void> close() async {
    await stopRecording();
    stopTimer();
    return super.close();
  }
}

//0 - 59 -> normal
//

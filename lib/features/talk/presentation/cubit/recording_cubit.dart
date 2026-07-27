import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/convert_audio.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/load_whisper_model.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/start_recording.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/stop_recording.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/transcribe_audio.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_state.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

@injectable
class RecordingCubit extends Cubit<RecordingState> {
  final StartRecording startRecording;
  final StopRecording stopRecording;
  final LoadWhisperModel loadWhisperModel;
  final TranscribeAudio transcribeAudio;
  final ConvertAudio convertAudio;

  RecordingCubit({
    required this.loadWhisperModel,
    required this.startRecording,
    required this.stopRecording,
    required this.convertAudio,
    required this.transcribeAudio,
  }) : super(const RecordingState());

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
      (r) async {
        emit(state.copyWith(isRecording: false, audioPath: r));
        final convertedAudio = await convertAudio(r ?? "");

        WhisperMethodChannel.progressStream.listen((progress) {
          print("Progress: $progress%");
        });

        final text = await transcribeAudio(convertedAudio ?? "");

        print("what is x $convertedAudio");
        print("what is texttt $text");
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

  Future<void> loadWhisperModelCall() async {
    final path = await getModelPath("ggml-base.bin");

    await loadWhisperModel(path);
  }

  Future<String> getModelPath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();

    return p.join(dir.path, "models", fileName);
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

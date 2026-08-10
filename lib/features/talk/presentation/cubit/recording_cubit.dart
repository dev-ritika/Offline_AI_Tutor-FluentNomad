import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/audio_level_stream.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/cancel_transcription.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/convert_audio.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/load_whisper_model.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/start_audio_level_stream.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/start_recording.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/stop_audio_level_stream.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/stop_recording.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/transcribe_audio.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/transcription_audio_stream.dart';
import 'package:offline_ai_tutor/features/talk/domain/use_cases/transcription_progress_stream.dart';
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
  final CancelTranscription cancelTranscription;
  final TranscriptionProgressStream transcriptionProgressStream;
  final TranscriptionAudioStream transcriptionAudioStream;
  final AudioLevelStream audioLevelStream;
  final StartAudioLevelStream startAudioLevelStream;
  final StopAudioLevelStream stopAudioLevelStream;

  StreamSubscription<String>? _transcriptSubscription;
  StreamSubscription<int>? _progressSubscription;
  StreamSubscription<double>? _streamSubscription;

  RecordingCubit({
    required this.loadWhisperModel,
    required this.startRecording,
    required this.stopRecording,
    required this.convertAudio,
    required this.transcribeAudio,
    required this.transcriptionProgressStream,
    required this.cancelTranscription,
    required this.transcriptionAudioStream,
    required this.startAudioLevelStream,
    required this.stopAudioLevelStream,
    required this.audioLevelStream,
  }) : super(const RecordingState()) {
    _progressSubscription = transcriptionProgressStream().listen((progress) {
      print("Progress: $progress%");
    });

    _transcriptSubscription = transcriptionAudioStream.getStream.listen((text) {
      print("texttt $text");
      // emit(state.copyWith(transcriptedText: text));
      addWhisperText(text);
    });

    _streamSubscription = audioLevelStream().listen((data) {
      print("audio level $data");
    });
  }

  void addAudioLevel(double data) {
    double audioLevel = double.tryParse(data.toStringAsFixed(2)) ?? 0;
  }

  Future<void> startAudioRecording() async {
    emit(state.copyWith(isRecording: true));

    await startAudioLevelStream();

    final data = await startRecording();

    data.fold(
      (l) {
        emit(state.copyWith(isRecording: false, failure: l));
      },
      (r) {
        emit(state.copyWith(failure: null, isRecording: true));
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
        emit(
          state.copyWith(
            isRecording: false,
            audioPath: r,
            isTranscribing: true,
          ),
        );

        final convertedAudio = await convertAudio(r ?? "");

        await transcribeAudio(convertedAudio ?? "");

        await cancelTranscription();

        emit(state.copyWith(isTranscribing: false));

        await stopAudioLevelStream();

        _displayText = "";
      },
    );
  }

  Timer? _transcriptTimer;

  String _displayText = "";

  void addWhisperText(String text) {
    _transcriptTimer?.cancel();

    int index = 0;

    print("coming textt $text $index");

    _transcriptTimer = Timer.periodic(const Duration(milliseconds: 40), (
      timer,
    ) {
      print("heree");

      if (index >= text.length) {
        timer.cancel();

        print("here 1");

        return;
      }

      print("coming textt 1 $text");

      print("display textt ${_displayText}");

      _displayText += text[index];

      index++;

      emit(state.copyWith(transcriptedText: _displayText));
    });
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
    _streamSubscription?.cancel();
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
    _transcriptTimer?.cancel();
    await _progressSubscription?.cancel();
    await _transcriptSubscription?.cancel();
    return super.close();
  }
}

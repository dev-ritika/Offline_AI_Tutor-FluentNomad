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
}

import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';

class RecordingState extends Equatable {
  final Failures? failure;
  final String? audioPath;
  final bool isRecording;

  const RecordingState({
    this.failure,
    this.audioPath,
    this.isRecording = false,
  });

  RecordingState copyWith({
    Failures? failure,
    String? audioPath,
    bool? isRecording,
  }) {
    return RecordingState(
      audioPath: audioPath ?? this.audioPath,
      failure: failure ?? this.failure,
      isRecording: isRecording ?? this.isRecording,
    );
  }

  @override
  List<Object?> get props => [failure, audioPath, isRecording];
}

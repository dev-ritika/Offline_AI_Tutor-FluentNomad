import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';

class RecordingState extends Equatable {
  final Failures? failure;
  final String? audioPath;
  final bool isRecording;
  final String? recordingTime;

  const RecordingState({
    this.failure,
    this.audioPath,
    this.isRecording = false,
    this.recordingTime = "00 : 00 : 00",
  });

  RecordingState copyWith({
    Failures? failure,
    String? audioPath,
    bool? isRecording,
    String? recordingTime,
  }) {
    return RecordingState(
      audioPath: audioPath ?? this.audioPath,
      failure: failure ?? this.failure,
      isRecording: isRecording ?? this.isRecording,
      recordingTime: recordingTime ?? this.recordingTime,
    );
  }

  @override
  List<Object?> get props => [failure, audioPath, isRecording, recordingTime];
}

import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';

class RecordingState extends Equatable {
  final Failures? failure;
  final String? audioPath;
  final bool isRecording;
  final bool isTranscribing;
  final String? recordingTime;
  final String? transcriptedText;

  const RecordingState({
    this.failure,
    this.audioPath,
    this.isRecording = false,
    this.isTranscribing = false,
    this.recordingTime = "00 : 00 : 00",
    this.transcriptedText,
  });

  RecordingState copyWith({
    Failures? failure,
    String? audioPath,
    bool? isRecording,
    bool? isTranscribing,
    String? recordingTime,
    String? transcriptedText,
  }) {
    return RecordingState(
      audioPath: audioPath ?? this.audioPath,
      failure: failure ?? this.failure,
      isRecording: isRecording ?? this.isRecording,
      recordingTime: recordingTime ?? this.recordingTime,
      transcriptedText: transcriptedText ?? this.transcriptedText,
      isTranscribing: isTranscribing ?? this.isTranscribing,
    );
  }

  @override
  List<Object?> get props => [
    failure,
    audioPath,
    isRecording,
    recordingTime,
    transcriptedText,
    isTranscribing,
  ];
}

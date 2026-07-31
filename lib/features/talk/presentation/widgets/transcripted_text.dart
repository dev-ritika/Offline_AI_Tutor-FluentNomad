import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/common_widgets/chat_bubble.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_cubit.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_state.dart';

class TranscriptedText extends StatelessWidget {
  const TranscriptedText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RecordingCubit, RecordingState, String?>(
      selector: (state) => state.transcriptedText,
      builder: (context, state) => state == null
          ? const SizedBox.shrink()
          : ChatBubble(childText: state),
    );
  }
}

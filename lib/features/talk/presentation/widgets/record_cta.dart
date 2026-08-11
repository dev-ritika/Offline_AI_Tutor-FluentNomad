import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_cubit.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_state.dart';
import 'package:offline_ai_tutor/features/talk/presentation/widgets/record_cta_widget.dart';
import 'package:offline_ai_tutor/features/talk/presentation/widgets/record_timer.dart';

class RecordCta extends StatefulWidget {
  const RecordCta({super.key});

  @override
  State<RecordCta> createState() => _RecordCtaState();
}

class _RecordCtaState extends State<RecordCta> {
  bool isTapped = false;

  void tapAction() async {
    if (isTapped) {
      context.read<RecordingCubit>().stopAudioRecording();
      context.read<RecordingCubit>().stopTimer();
    } else {
      context.read<RecordingCubit>().startAudioRecording();
      context.read<RecordingCubit>().startTimer();
    }
    setState(() {
      isTapped = !isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<RecordingCubit, RecordingState, double>(
          selector: (state) {
            return isTapped ? state.audioLevel : 0;
          },
          builder: (context, data) {
            return RecordCtaWidget(callback: tapAction, audioLevel: data);
          },
        ),

        //
        Text(isTapped ? "Tap to stop" : "Tap to start"),
        const SizedBox(height: 10),

        const RecordTimer(),

        // BlocSelector<RecordingCubit, RecordingState, String?>(
        //   selector: (state) {
        //     return state.audioPath;
        //   },
        //   builder: (context, audioPath) {
        //     return TextButton(
        //       onPressed: () async {
        //         final player = AudioPlayer();

        //         print("wht is it $audioPath");

        //         if (audioPath != null) {
        //           print("playedd");
        //           await player.play(DeviceFileSource(audioPath));
        //         }
        //       },
        //       child: Text("try audio"),
        //     );
        //   },
        // ),
      ],
    );
  }
}

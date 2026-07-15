import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_cubit.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_state.dart';
import 'package:offline_ai_tutor/features/talk/presentation/widgets/record_cta_widget.dart';

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
    } else {
      context.read<RecordingCubit>().startAudioRecording();
    }
    setState(() {
      isTapped = !isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecordCtaWidget(callback: tapAction),

        const SizedBox(height: 10),

        Text(isTapped ? "Tap to stop" : "Tap to start"),

        BlocSelector<RecordingCubit, RecordingState, String?>(
          selector: (state) {
            return state.audioPath;
          },
          builder: (context, audioPath) {
            return TextButton(
              onPressed: () async {
                final player = AudioPlayer();

                print("wht is it $audioPath");

                if (audioPath != null) {
                  print("playedd");
                  await player.play(DeviceFileSource(audioPath));
                }
              },
              child: Text("try audio"),
            );
          },
        ),
      ],
    );
  }
}

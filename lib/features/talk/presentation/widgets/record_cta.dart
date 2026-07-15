import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';
import 'package:offline_ai_tutor/features/talk/data/data_source/recording_data_source.dart';

class RecordCta extends StatefulWidget {
  const RecordCta({super.key});

  @override
  State<RecordCta> createState() => _RecordCtaState();
}

class _RecordCtaState extends State<RecordCta> {
  bool isTapped = false;
  String? audioPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            // isTapped
            //     ? audioPath = await sl<RecordingDataSource>().stopRecording()
            //     : sl<RecordingDataSource>().startRecording();

            // setState(() {
            //   isTapped = !isTapped;
            // });

            // print("audio camee $audioPath");
          },

          child: const CircleAvatar(
            backgroundColor: ColorConsts.buttonSecondaryColor,
            radius: 50,
            child: CircleAvatar(
              backgroundColor: ColorConsts.buttonSecondaryStrokeColor,
              radius: 40,
              child: CircleAvatar(
                backgroundColor: ColorConsts.buttonPLinearColor1,
                radius: 30,
                child: Icon(Icons.mic, size: 30),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(isTapped ? "Tap to stop" : "Tap to start"),

        TextButton(
          onPressed: () async {
            final player = AudioPlayer();

            print("wht is it $audioPath");

            if (audioPath != null) {
              print("playedd");
              await player.play(DeviceFileSource(audioPath!));
            }
          },
          child: Text("try audio"),
        ),
      ],
    );
  }
}

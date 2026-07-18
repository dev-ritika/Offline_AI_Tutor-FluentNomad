import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';
import 'package:offline_ai_tutor/features/talk/presentation/cubit/recording_cubit.dart';
import 'package:offline_ai_tutor/features/talk/presentation/widgets/record_cta.dart';
import 'package:offline_ai_tutor/features/talk/presentation/widgets/talk_screen_header.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class TalkScreenWidget extends StatefulWidget {
  const TalkScreenWidget({super.key});

  @override
  State<TalkScreenWidget> createState() => _TalkScreenWidgetState();
}

class _TalkScreenWidgetState extends State<TalkScreenWidget> {
  //flutter: where downloaded /Users/elred/Library/Developer/CoreSimulator/Devices/2CB20222-4D0E-4D7E-809D-3E2597BD6AC0/data/Containers/Data/Application/B7358758-6E24-49D5-B22D-51D058BAB7B5/Documents/models/en_US-lessac-medium.onnx

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<RecordingCubit>().loadWhisperModelCall();

      // final text = await WhisperMethodChannel().transcribe("audioPath");

      // print(text);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [TalkScreenHeader(), Spacer(), RecordCta()],
          ),
        ),
      ),
    );
  }
}

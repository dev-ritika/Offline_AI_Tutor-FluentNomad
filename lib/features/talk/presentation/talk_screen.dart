import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';

class TalkScreen extends StatelessWidget {
  const TalkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WhisperMethodChannel().getText(
      modelPath: "...",
      audioPath: "...",
      language: "ja",
    );
    return Scaffold(appBar: AppBar(), body: const Text("TalkScreen"));
  }
}

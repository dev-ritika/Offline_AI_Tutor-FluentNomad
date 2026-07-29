import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';
import 'package:offline_ai_tutor/features/talk/presentation/utils/transcript_text_controller.dart';

class TranscriptedText extends StatefulWidget {
  const TranscriptedText({super.key});

  @override
  State<TranscriptedText> createState() => _TranscriptedTextState();
}

class _TranscriptedTextState extends State<TranscriptedText> {
  late TranscriptTextController textController;

  @override
  void initState() {
    textController = TranscriptTextController();

    WhisperMethodChannel().transcriptStream.listen((text) {
      print("listenn text $text");
      textController.addWhisperText(text);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: textController.stream,
      builder: (context, snapshot) {
        return Text(snapshot.data ?? "heyyy");
      },
    );
  }
}

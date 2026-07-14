import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/features/talk/data/platform/whisper_method_channel.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class TalkScreen extends StatefulWidget {
  const TalkScreen({super.key});

  @override
  State<TalkScreen> createState() => _TalkScreenState();
}

class _TalkScreenState extends State<TalkScreen> {
  //flutter: where downloaded /Users/elred/Library/Developer/CoreSimulator/Devices/2CB20222-4D0E-4D7E-809D-3E2597BD6AC0/data/Containers/Data/Application/B7358758-6E24-49D5-B22D-51D058BAB7B5/Documents/models/en_US-lessac-medium.onnx

  Future<String> getModelPath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();

    return p.join(dir.path, "models", fileName);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // WhisperMethodChannel().getText(
      //   modelPath: "...",
      //   audioPath: "...",
      //   language: "ja",
      // );

      final path = await getModelPath("ggml-base.bin");

      print("what is the path $path");

      WhisperMethodChannel().loadModel(path);

      final text = await WhisperMethodChannel().transcribe("audioPath");

      print(text);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const Text("TalkScreen"));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/features/record_learn/presentation/cubit/recording_cubit.dart';
import 'package:offline_ai_tutor/features/record_learn/presentation/screen/talk_screen_widget.dart';

class TalkScreen extends StatelessWidget {
  const TalkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RecordingCubit>(),
      child: const TalkScreenWidget(),
    );
  }
}

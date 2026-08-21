import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';
import 'package:offline_ai_tutor/features/record_learn/presentation/cubit/recording_cubit.dart';
import 'package:offline_ai_tutor/features/record_learn/presentation/cubit/recording_state.dart';

class RecordTimer extends StatelessWidget {
  const RecordTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RecordingCubit, RecordingState, String?>(
      selector: (state) => state.recordingTime,
      builder: (context, data) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: ColorConsts.buttonErrorStrokeColor,
            border: Border.all(width: 1, color: ColorConsts.errorColor),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Text(
            data ?? "",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: ColorConsts.errorColor),
          ),
        );
      },
    );
  }
}

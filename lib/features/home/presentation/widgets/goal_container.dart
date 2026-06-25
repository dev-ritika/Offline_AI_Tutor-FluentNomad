import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/common_widgets/selectable_container.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';
import 'package:offline_ai_tutor/core/utils/helpers/container_color_model.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_cubit.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_state.dart';

class GoalContainer extends StatelessWidget {
  const GoalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeDataCubit, HomeDataState, int>(
      selector: (state) {
        return state.elapsedTime;
      },
      builder: (context, data) {
        return SelectableContainer(
          title: "Today's goal",
          subtitle: "$data / 30 mins today",
          trailingItem: Text(
            ('${(calculateProgress(data) * 100).round().toString()}%'),
            style: TextTheme.of(
              context,
            ).copyWith().bodyMedium?.copyWith(color: ColorConsts.successColor),
          ),

          bottemItem: LinearProgressIndicator(
            value: calculateProgress(data),
            backgroundColor:
                ContainerColorModel.successColorModel.progressBgColor,
            color: ContainerColorModel.successColorModel.progressColor,
          ),

          containerColorModel: ContainerColorModel.successColorModel,
        );
      },
    );
  }
}

double calculateProgress(int elapsedTime) {
  double progress = 0;

  progress = (elapsedTime / 30);

  return progress;
}

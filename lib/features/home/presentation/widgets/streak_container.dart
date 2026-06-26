import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/common_widgets/selectable_container.dart';
import 'package:offline_ai_tutor/core/utils/helpers/container_color_model.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_cubit.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_state.dart';
import 'package:offline_ai_tutor/features/home/presentation/utils/home_formatters.dart';

class StreakContainer extends StatelessWidget {
  const StreakContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeDataCubit, HomeDataState, int>(
      selector: (state) {
        return state.streakDays;
      },
      builder: (context, data) {
        return SelectableContainer(
          leadingIcon: const Text("🔥", style: TextStyle(fontSize: 30)),
          title: HomeFormatters.streakText(data),
          subtitle: "complete today's session to keep it going ",
          containerColorModel: ContainerColorModel.warningColorModel,
          allowOverflow: false,
        );
      },
    );
  }
}

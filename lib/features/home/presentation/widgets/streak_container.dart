import 'package:flutter/widgets.dart';
import 'package:offline_ai_tutor/core/common_widgets/selectable_container.dart';
import 'package:offline_ai_tutor/core/utils/helpers/container_color_model.dart';

class StreakContainer extends StatelessWidget {
  const StreakContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableContainer(
      leadingIcon: Text("🔥", style: TextStyle(fontSize: 30)),
      title: "12 day streak",
      subtitle: "complete today's session to keep it going ",
      containerColorModel: ContainerColorModel.warningColorModel,
      allowOverflow: false,
    );
  }
}

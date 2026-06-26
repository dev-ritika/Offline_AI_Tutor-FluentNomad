import 'package:flutter/widgets.dart';
import 'package:offline_ai_tutor/core/common_widgets/info_container.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/user_actions.dart';

class ActionsGrid extends StatelessWidget {
  const ActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        mainAxisExtent: 117,
      ),
      itemCount: UserActions.userActionsList.length,

      itemBuilder: (context, index) {
        final data = UserActions.userActionsList[index];
        return InfoContainer(
          subtitle: data.subTitle,
          title: data.title,
          topIcon: Image.asset(data.imageUrl, height: 40, width: 40),
          onTap: () {},
        );
      },
    );
  }
}

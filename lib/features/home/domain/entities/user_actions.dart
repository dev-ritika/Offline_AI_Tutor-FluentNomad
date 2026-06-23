import 'package:offline_ai_tutor/core/utils/constants/assets_consts.dart';

class UserActions {
  final String imageUrl;
  final String title;
  final String subTitle;

  const UserActions({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  });

  static const List<UserActions> userActionsList = [
    UserActions(
      imageUrl: AssetsConsts.talkIcon,
      title: "Talk",
      subTitle: "Try conversation",
    ),
    UserActions(
      imageUrl: AssetsConsts.reviewIcon,
      title: "Review",
      subTitle: "Review cards",
    ),
    UserActions(
      imageUrl: AssetsConsts.readIcon,
      title: "Read",
      subTitle: "New article ready",
    ),
    UserActions(
      imageUrl: AssetsConsts.writeIcon,
      title: "Write",
      subTitle: "Daily prompt writing",
    ),
  ];
}

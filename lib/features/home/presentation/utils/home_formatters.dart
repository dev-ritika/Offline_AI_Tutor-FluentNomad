import 'package:offline_ai_tutor/core/utils/constants/global_consts.dart';

class HomeFormatters {
  static double calculateProgress(int elapsedTime) {
    double progress = 0;

    progress = (elapsedTime / GlobalConsts.kDailyGoalMinutes).clamp(0.0, 1.0);

    return progress;
  }

  static String streakText(int data) {
    if (data <= 1) {
      return "$data day streak";
    } else {
      return "$data days streak";
    }
  }
}

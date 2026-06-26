import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/config/routes/routes_names.dart';
import 'package:offline_ai_tutor/features/home/presentation/screen/home.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/screen/onboarding.dart';

class RoutesConfig {
  RoutesConfig._();

  static Map<String, WidgetBuilder> getRoutes = {
    RoutesNames.onboardingScreen: (context) {
      final OnboardingCubit onboardingCubit =
          ModalRoute.of(context)?.settings.arguments as OnboardingCubit;
      return OnboardingScreen(onboardingCubit: onboardingCubit);
    },
    RoutesNames.homeScreen: (context) {
      return const HomeScreen();
    },
  };
}

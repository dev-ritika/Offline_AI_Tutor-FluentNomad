import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/config/routes/routes_names.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:offline_ai_tutor/features/splash/presentation/widgets/splash_logo.dart';
import 'package:offline_ai_tutor/features/splash/presentation/widgets/splash_text.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<OnboardingCubit>();

    return BlocProvider.value(value: cubit, child: const SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((x) {
        final bool onboardingCompleted = context
            .read<OnboardingCubit>()
            .updateOnboardingStatus();

        if (onboardingCompleted) {
          Navigator.of(context).pushNamed(RoutesNames.homeScreen);
        } else {
          Navigator.of(context).pushReplacementNamed(
            RoutesNames.onboardingScreen,
            arguments: context.read<OnboardingCubit>(),
          );
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [SplashLogo(), SplashText()],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/user_details_container.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class HomeScreen extends StatelessWidget {
  final OnboardingCubit onboardingCubit;
  const HomeScreen({super.key, required this.onboardingCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: onboardingCubit,
      child: const Scaffold(body: Center(child: UserDetailsContainer())),
    );
  }
}

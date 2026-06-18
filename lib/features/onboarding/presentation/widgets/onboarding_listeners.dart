import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offline_ai_tutor/config/routes/routes_names.dart';
import 'package:offline_ai_tutor/core/utils/enums/state_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_state.dart';

class OnboardingListeners extends StatelessWidget {
  final Widget child;
  final PageController pageController;

  const OnboardingListeners({
    super.key,
    required this.child,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OnboardingCubit, OnboardingState>(
          listenWhen: (previous, current) =>
              previous.currentStep != current.currentStep,
          listener: (context, state) {
            pageController.animateToPage(
              state.currentStep.currentStep - 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
        ),

        BlocListener<OnboardingCubit, OnboardingState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == StateStatusEnum.error,
          listener: (context, state) {
            Fluttertoast.showToast(
              msg: state.error?.message ?? "Something went wrong",
            );
          },
        ),

        BlocListener<OnboardingCubit, OnboardingState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == StateStatusEnum.saved,
          listener: (context, state) {
            Navigator.of(context).pushNamed(RoutesNames.homeScreen);
            Fluttertoast.showToast(msg: "Saved successfully");

            //TO DO code to navigate next screen
          },
        ),
      ],

      child: child,
    );
  }
}

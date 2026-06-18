import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/onboarding_header_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/widgets/onboarding_action.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/widgets/onboarding_listeners.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/widgets/onboarding_loader.dart';

class OnboardingScreen extends StatefulWidget {
  final OnboardingCubit onboardingCubit;
  const OnboardingScreen({super.key, required this.onboardingCubit});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.onboardingCubit,
      //create: (context) => sl<OnboardingCubit>(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: OnboardingListeners(
          pageController: _pageController,
          child: Stack(
            children: [
              BlocSelector<OnboardingCubit, OnboardingState, bool>(
                selector: (state) {
                  return state.currentStep == OnboardingStepEnum.language;
                },
                builder: (context, canBePopped) {
                  return PopScope(
                    canPop: canBePopped,
                    onPopInvokedWithResult: (didPop, result) {
                      if (didPop) return;
                      context.read<OnboardingCubit>().goBack();
                    },
                    child: Scaffold(
                      body: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 25,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    //header
                                    const OnboardingHeader(),
                                    //content
                                    Expanded(
                                      child: OnboardingContent(
                                        pageController: _pageController,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //button
                              const OnboardingAction(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              //loader
              const OnboardingLoader(),
            ],
          ),
        ),
      ),
    );
  }
}

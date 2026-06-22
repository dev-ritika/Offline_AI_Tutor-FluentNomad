import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_state.dart';

class UserDetailsContainer extends StatelessWidget {
  const UserDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OnboardingCubit, OnboardingState, String?>(
      selector: (state) => state.enteredName,
      builder: (context, data) {
        return Text(data ?? "");
      },
    );
  }
}

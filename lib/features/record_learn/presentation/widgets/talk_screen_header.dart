import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/user/presentation/cubit/user_data_cubit.dart';
import 'package:offline_ai_tutor/features/user/presentation/cubit/user_data_state.dart';

class TalkScreenHeader extends StatelessWidget {
  const TalkScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserDataCubit, UserDataState, UserData?>(
      selector: (state) => state.userData,
      builder: (context, data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Talk and learn",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 3),
            Text(
              ("${(data?.selectedLevel.code ?? "")} · ${(data?.selectedLanguage.langName ?? "")} "),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 18),
          ],
        );
      },
    );
  }
}

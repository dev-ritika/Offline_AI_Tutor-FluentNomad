import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/utils/constants/assets_consts.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/user/presentation/cubit/user_data_cubit.dart';
import 'package:offline_ai_tutor/features/user/presentation/cubit/user_data_state.dart';

class UserDetailsContainer extends StatelessWidget {
  const UserDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserDataCubit, UserDataState, UserData?>(
      selector: (state) => state.userData,
      builder: (context, data) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Hi, ${data?.userName}"),

                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(
                            AssetsConsts.waveGif,
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  "Your ${data?.selectedLanguage.langName} awaits",
                  style: TextTheme.of(context).titleLarge,
                ),
              ],
            ),

            CircleAvatar(
              child: Text(
                data?.userName.substring(0, 1) ?? "",
                style: TextTheme.of(context).titleLarge,
              ),
            ),
          ],
        );
      },
    );
  }
}

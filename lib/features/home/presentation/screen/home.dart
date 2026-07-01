import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_cubit.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/actions_grid.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/goal_container.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/streak_container.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/user_details_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDetailsContainer(),
                SizedBox(height: 20),
                StreakContainer(),
                SizedBox(height: 20),
                Text("QUICK START ✌️"),
                SizedBox(height: 10),
                ActionsGrid(),
                SizedBox(height: 20),
                Text("MAINTAIN YOUR STREAK ⏱️"),
                SizedBox(height: 10),
                GoalContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

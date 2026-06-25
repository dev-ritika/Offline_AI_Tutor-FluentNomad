import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_cubit.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_state.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/actions_grid.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/goal_container.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/streak_container.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/user_details_container.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class HomeScreen extends StatefulWidget {
  final OnboardingCubit onboardingCubit;
  const HomeScreen({super.key, required this.onboardingCubit});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  List screensList = [];

  @override
  void initState() {
    screensList = [
      HomeScreen(onboardingCubit: widget.onboardingCubit),
      HomeScreen(onboardingCubit: widget.onboardingCubit),
      HomeScreen(onboardingCubit: widget.onboardingCubit),
      HomeScreen(onboardingCubit: widget.onboardingCubit),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) {
            return sl<HomeDataCubit>();
          },
        ),
        BlocProvider.value(value: widget.onboardingCubit),
      ],
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(Icons.abc),
        //   shape: CircleBorder(),
        //   backgroundColor: ColorConsts.primaryColor50,
        // ),
        //  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: const <IconData>[
            Icons.home,
            Icons.mic,
            Icons.menu_book_outlined,
            Icons.auto_graph_rounded,
          ],
          onTap: (int index) {
            setState(() {
              screenIndex = index;
            });
          },
          activeIndex: screenIndex,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          gapLocation: GapLocation.none,
          backgroundColor: ColorConsts.buttonSecondaryColor,
          activeColor: ColorConsts.primaryColor,
          blurEffect: true,
          elevation: 20,
          leftCornerRadius: 25,
          rightCornerRadius: 25,

          // notchMargin: 20,
        ),

        body: const SafeArea(
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

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';
import 'package:offline_ai_tutor/features/Dummy/presentation/dummy_screen.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_cubit.dart';
import 'package:offline_ai_tutor/features/home/presentation/screen/home.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/actions_grid.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/goal_container.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/streak_container.dart';
import 'package:offline_ai_tutor/features/home/presentation/widgets/user_details_container.dart';

class NavigatorTab extends StatefulWidget {
  const NavigatorTab({super.key});

  @override
  State<NavigatorTab> createState() => _NavigatorTabState();
}

class _NavigatorTabState extends State<NavigatorTab> {
  int screenIndex = 0;
  List<Widget> screensList = [];

  @override
  void initState() {
    screensList = [
      const HomeScreen(),
      const DummyScreen(),
      const HomeScreen(),
      const HomeScreen(),
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
            return sl<HomeDataCubit>()..getUserLocalData();
          },
        ),
      ],
      child: Scaffold(
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

        body: screensList[screenIndex],
      ),
    );
  }
}

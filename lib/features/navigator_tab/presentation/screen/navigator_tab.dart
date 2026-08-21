import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';
import 'package:offline_ai_tutor/features/record_learn/presentation/screen/talk_screen.dart';
import 'package:offline_ai_tutor/features/home/presentation/screen/home.dart';

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
      const TalkScreen(),
      const HomeScreen(),
      const HomeScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

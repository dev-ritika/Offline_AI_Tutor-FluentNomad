import 'dart:math';
import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';

class RecordCtaWidget extends StatefulWidget {
  final VoidCallback? callback;
  final bool isTapped;

  const RecordCtaWidget({super.key, this.callback, this.isTapped = false});

  @override
  State<RecordCtaWidget> createState() => _RecordCtaWidgetState();
}

class _RecordCtaWidgetState extends State<RecordCtaWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController fadeController;

  late Animation<double> animation;
  late Animation<double> fadeAnimation;
  bool isTapped = false;

  @override
  void initState() {
    isTapped = widget.isTapped;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(
      begin: 20 + Random().nextDouble() * 20,
      end: 40 + Random().nextDouble() * 20,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    fadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: fadeController, curve: Curves.ease));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "record_cta",
      child: GestureDetector(
        onTap: () {
          widget.callback?.call();

          if (!isTapped) {
            print("called 1");
            controller.forward();
            controller.repeat();

            fadeController.forward();
            fadeController.repeat();
            isTapped = !isTapped;
          } else {
            print("called 2");
            controller.stop();
            fadeController.stop();
            isTapped = !isTapped;
          }
        },

        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return SizedBox(
              width: 125,
              height: 125,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer animated circle
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: (animation.value + 8) * 2,
                    height: (animation.value + 8) * 2,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(animation.value + 16),
                      ),
                      color: ColorConsts.buttonSecondaryColor,
                    ),
                  ),

                  // Middle animated circle
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: (animation.value - 5) * 2,
                    height: (animation.value - 5) * 2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConsts.buttonSecondaryStrokeColor,
                    ),
                  ),

                  // Fixed center
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: ColorConsts.buttonPLinearColor1,
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: const Icon(Icons.mic, size: 30),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

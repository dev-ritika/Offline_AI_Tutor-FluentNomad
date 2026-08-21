import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';

class RecordCtaWidget extends StatefulWidget {
  final VoidCallback? callback;
  final double audioLevel;

  const RecordCtaWidget({super.key, this.callback, required this.audioLevel});

  @override
  State<RecordCtaWidget> createState() => _RecordCtaWidgetState();
}

class _RecordCtaWidgetState extends State<RecordCtaWidget>
    with TickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  bool isTapped = false;

  double audioLevel = 0;

  @override
  void initState() {
    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    fadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: fadeController, curve: Curves.ease));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant RecordCtaWidget oldWidget) {
    audioLevel = 40 + (widget.audioLevel * 100);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
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
            fadeController.forward();
            fadeController.repeat();
            isTapped = !isTapped;
          } else {
            fadeController.stop();
            isTapped = !isTapped;
          }
        },

        child: AnimatedBuilder(
          animation: fadeAnimation,
          builder: (context, child) {
            return SizedBox(
              width: 125,
              height: 125,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer animated circle
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: (audioLevel) * 1.6,
                    height: (audioLevel) * 1.6,
                    decoration: const BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: ColorConsts.buttonSecondaryColor,
                    ),
                  ),

                  // Middle animated circle
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: (audioLevel * 1.3),
                    height: (audioLevel * 1.3),
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

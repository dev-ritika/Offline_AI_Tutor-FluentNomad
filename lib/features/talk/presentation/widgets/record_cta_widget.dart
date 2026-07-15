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
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    animation = Tween<double>(
      begin: 20 + Random().nextDouble() * 20,
      end: 40 + Random().nextDouble() * 20,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    controller.forward();
    controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "record_cta",
      child: GestureDetector(
        onTap: widget.callback,

        child: CircleAvatar(
          backgroundColor: ColorConsts.buttonSecondaryColor,
          radius: 50,
          child: CircleAvatar(
            backgroundColor: ColorConsts.buttonSecondaryStrokeColor,
            radius: 40,
            child: CircleAvatar(
              backgroundColor: ColorConsts.buttonPLinearColor1,
              radius: 30,
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Icon(Icons.mic, size: animation.value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

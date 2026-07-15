import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';

class RecordCtaWidget extends StatelessWidget {
  final VoidCallback? callback;

  const RecordCtaWidget({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "record_cta",
      child: GestureDetector(
        onTap: callback,

        child: const CircleAvatar(
          backgroundColor: ColorConsts.buttonSecondaryColor,
          radius: 50,
          child: CircleAvatar(
            backgroundColor: ColorConsts.buttonSecondaryStrokeColor,
            radius: 40,
            child: CircleAvatar(
              backgroundColor: ColorConsts.buttonPLinearColor1,
              radius: 30,
              child: Icon(Icons.mic, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}

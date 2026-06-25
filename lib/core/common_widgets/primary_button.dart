import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  final bool showLoader;

  const PrimaryButton({
    super.key,
    this.onTap,
    required this.buttonText,
    this.showLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              colors: onTap == null
                  ? [
                      ColorConsts.buttonSecondaryStrokeColor,
                      ColorConsts.buttonSecondaryStrokeColor,
                    ]
                  : [
                      ColorConsts.buttonPLinearColor1,
                      ColorConsts.buttonPLinearColor2,
                    ],
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: double.infinity,
              height: 46,
              child: Center(
                child: showLoader
                    ? const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: ColorConsts.whiteColor,
                        ),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: buttonText,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const WidgetSpan(
                              // baseline: TextBaseline.alphabetic,
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: ColorConsts.whiteColor,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

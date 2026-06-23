import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/common_widgets/select_icon.dart';
import 'package:offline_ai_tutor/core/utils/helpers/container_color_model.dart';

class InfoContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final ContainerColorModel containerColorModel;
  final Widget? topIcon;
  final String title;
  final String subtitle;
  final bool allowOverflow;
  final VoidCallback? onTap;

  const InfoContainer({
    super.key,
    this.containerColorModel = ContainerColorModel.containerColorModel,
    required this.title,
    required this.subtitle,
    this.allowOverflow = true,
    this.height,
    this.width,
    this.topIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: onTap,
        child: Container(
          height: height,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              style: BorderStyle.solid,
              width: 1.2,

              color: containerColorModel.borderColor!,
            ),
            gradient: LinearGradient(
              colors: [
                containerColorModel.gradientColor1 ??
                    containerColorModel.containerColor!,
                containerColorModel.gradientColor2 ??
                    containerColorModel.containerColor!,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topIcon ?? const SizedBox.shrink(),

                SizedBox(height: 10),

                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: containerColorModel.titleColor,
                  ),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: containerColorModel.subTitleColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

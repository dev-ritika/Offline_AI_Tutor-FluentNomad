import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/common_widgets/select_icon.dart';
import 'package:offline_ai_tutor/core/utils/helpers/container_color_model.dart';

class SelectableContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final bool isSelected;
  final ContainerColorModel containerColorModel;
  final Widget? leadingIcon;
  final String title;
  final String subtitle;
  final Widget? trailingItem;
  final Widget? bottemItem;
  final VoidCallback? onTap;
  final bool allowOverflow;

  const SelectableContainer({
    super.key,
    this.onTap,
    this.containerColorModel = ContainerColorModel.containerColorModel,
    required this.title,
    required this.subtitle,
    this.allowOverflow = true,
    this.height,
    this.width,
    this.isSelected = false,
    this.leadingIcon,
    this.bottemItem,
    this.trailingItem,
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    if (leadingIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: containerColorModel.avatarBgColor,
                          child: leadingIcon!,
                        ),
                      ),

                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: containerColorModel.titleColor,
                                ),
                          ),
                          Text(
                            subtitle,
                            overflow: allowOverflow
                                ? TextOverflow.ellipsis
                                : null,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: containerColorModel.subTitleColor,
                                ),
                          ),
                        ],
                      ),
                    ),

                    if (trailingItem != null) trailingItem!,

                    if (isSelected)
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: SelectIcon(),
                      ),
                  ],
                ),

                if (bottemItem != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: bottemItem,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

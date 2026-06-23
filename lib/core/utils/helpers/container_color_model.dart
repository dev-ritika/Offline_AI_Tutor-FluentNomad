import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/model_install_status_enum.dart';

class ContainerColorModel {
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? progressColor;
  final Color? progressBgColor;
  final Color? borderColor;
  final Color? avatarBgColor;
  final Color? containerColor;
  final Color? gradientColor1;
  final Color? gradientColor2;

  const ContainerColorModel({
    this.titleColor,
    this.subTitleColor,
    this.progressColor,
    this.progressBgColor,
    this.borderColor,
    this.avatarBgColor,
    this.containerColor,
    this.gradientColor1,
    this.gradientColor2,
  });

  static ContainerColorModel installationStatusColor(
    ModelInstallStatus status,
  ) {
    switch (status) {
      case (ModelInstallStatus.Queued):
        return yetToStartColorModel;
      case (ModelInstallStatus.Downloading):
        return wipColorModel;
      case (ModelInstallStatus.Downloaded):
        return successColorModel;
    }
  }

  static const ContainerColorModel successColorModel = ContainerColorModel(
    titleColor: ColorConsts.successColor,
    subTitleColor: ColorConsts.successColor50,
    progressColor: ColorConsts.successColor,
    progressBgColor: ColorConsts.successColor15,
    borderColor: ColorConsts.successColor15,
    avatarBgColor: ColorConsts.successColor15,
    containerColor: ColorConsts.successColor8,
  );

  static const ContainerColorModel wipColorModel = ContainerColorModel(
    titleColor: ColorConsts.primaryColor,
    subTitleColor: ColorConsts.primaryColor50,
    progressColor: ColorConsts.primaryColor,
    progressBgColor: ColorConsts.primaryColor15,
    borderColor: ColorConsts.primaryColor15,
    avatarBgColor: ColorConsts.primaryColor15,
    containerColor: ColorConsts.primaryColor8,
  );

  static const ContainerColorModel yetToStartColorModel = ContainerColorModel(
    titleColor: ColorConsts.disabledColor,
    progressColor: ColorConsts.disabledColor,
    subTitleColor: ColorConsts.disabledColor50,
    progressBgColor: ColorConsts.disabledColor15,
    borderColor: ColorConsts.disabledColor15,
    avatarBgColor: ColorConsts.disabledColor15,
    containerColor: ColorConsts.disabledColor8,
  );

  static const ContainerColorModel containerColorModel = ContainerColorModel(
    borderColor: ColorConsts.buttonSecondaryStrokeColor,
    gradientColor1: ColorConsts.buttonSecondaryColor,
    gradientColor2: ColorConsts.buttonSecondaryColor,
    containerColor: ColorConsts.buttonSecondaryColor,
    avatarBgColor: Colors.transparent,
    titleColor: ColorConsts.textPrimaryColor,
    subTitleColor: ColorConsts.whiteColor35,
  );

  static const ContainerColorModel warningColorModel = ContainerColorModel(
    borderColor: ColorConsts.warningColor25,
    gradientColor1: ColorConsts.warningColor12,
    gradientColor2: ColorConsts.warningColor12,
    containerColor: ColorConsts.warningColor12,
    avatarBgColor: Colors.transparent,
    titleColor: ColorConsts.warningColor,
    subTitleColor: ColorConsts.warningColor50,
  );
}

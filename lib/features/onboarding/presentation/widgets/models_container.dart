import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/core/common_widgets/selectable_container.dart';
import 'package:offline_ai_tutor/core/utils/helpers/sizebytes_converter.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/llm_model.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:offline_ai_tutor/core/utils/helpers/container_color_model.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/model_install_status_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_data.dart';

class ModelsContainer extends StatelessWidget {
  const ModelsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      OnboardingCubit,
      OnboardingState,
      ({LLMModelEntity? modelData, List<ModelInstallData>? modelInstallData})
    >(
      selector: (state) {
        return (
          modelData: state.modelsData,
          modelInstallData: state.modelInstallData,
        );
      },
      builder: (context, data) {
        final LLMModelEntity? modelData = data.modelData;

        final List<ModelInstallData>? modelInstallData = data.modelInstallData;

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: data.modelData?.models.length ?? 0,
          itemBuilder: (context, index) {
            return SelectableContainer(
              title:
                  "${(modelData?.models[index].displayName)}  ·  ${SizebytesConverter.getSize(modelData?.models[index].sizeBytes ?? 0)}",
              subtitle:
                  "${modelData?.models[index].subtitleDisplay}  |  ${installationStatus(modelInstallData == null ? ModelInstallData.initial() : modelInstallData[index])}",

              // "${modelData?.models[index].subtitleDisplay}  ",
              leadingIcon: getIcon(modelInstallData?[index].installedStatus),
              bottemItem: LinearProgressIndicator(
                value:
                    (modelInstallData?[index].installedPercentage ?? 0) / 100,
                minHeight: 3,
                // color: Colors.yellow,
                color: getProgressColor(modelInstallData, index),
                backgroundColor: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
              ),
              containerColorModel: ContainerColorModel.installationStatusColor(
                modelInstallData == null
                    ? ModelInstallStatusEnum.Queued
                    : modelInstallData[index].installedStatus,

                // ModelInstallStatusEnum.Downloading,
              ),
            );
          },
        );
      },
    );
  }
}

Color? getProgressColor(List<ModelInstallData>? modelInstallData, int index) {
  final Color? color = ContainerColorModel.installationStatusColor(
    modelInstallData == null
        ? ModelInstallStatusEnum.Queued
        : modelInstallData[index].installedStatus,
  ).progressColor;
  return color;
}

Widget getIcon(ModelInstallStatusEnum? status) {
  switch (status) {
    case (ModelInstallStatusEnum.Queued):
      return const Icon(Icons.query_builder_sharp);
    case (ModelInstallStatusEnum.Downloading):
      return const Icon(Icons.downloading_rounded);
    case (ModelInstallStatusEnum.Downloaded):
      return const Icon(Icons.file_download_done_rounded);
    default:
      return const Icon(Icons.query_builder_sharp);
  }
}

String installationStatus(ModelInstallData data) {
  if (data.installedStatus == ModelInstallStatusEnum.Queued) {
    return ModelInstallStatusEnum.Queued.name;
  } else if (data.installedStatus == ModelInstallStatusEnum.Downloaded) {
    return ModelInstallStatusEnum.Downloaded.name;
  } else {
    return "${data.installedPercentage} %";
  }
}

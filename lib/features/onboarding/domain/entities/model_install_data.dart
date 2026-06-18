import 'package:equatable/equatable.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/model_install_status_enum.dart';

class ModelInstallData extends Equatable {
  final String id;
  final int sizeInBytes;
  final String name;
  final int installedPercentage;
  final String url;
  final ModelInstallStatus installedStatus;

  const ModelInstallData({
    required this.id,
    required this.sizeInBytes,
    required this.name,
    required this.url,
    required this.installedPercentage,
    required this.installedStatus,
  });

  factory ModelInstallData.initial() {
    return const ModelInstallData(
      id: "",
      sizeInBytes: 0,
      installedPercentage: 0,
      installedStatus: ModelInstallStatus.Queued,
      name: "",
      url: "",
    );
  }

  ModelInstallData copyWith({
    String? id,
    int? sizeInBytes,
    String? name,
    String? url,
    int? installedPercentage,
    ModelInstallStatus? installedStatus,
  }) {
    return ModelInstallData(
      id: id ?? this.id,
      sizeInBytes: sizeInBytes ?? this.sizeInBytes,
      name: name ?? this.name,
      url: url ?? this.url,
      installedPercentage: installedPercentage ?? this.installedPercentage,
      installedStatus: installedStatus ?? this.installedStatus,
    );
  }

  @override
  List<Object?> get props => [
    id,
    sizeInBytes,
    name,
    installedPercentage,
    installedStatus,
    url,
  ];
}

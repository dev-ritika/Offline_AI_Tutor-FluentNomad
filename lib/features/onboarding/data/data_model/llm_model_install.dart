import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_type_ids.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_data.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/model_install_status_enum.dart';
part 'llm_model_install.g.dart';

@HiveType(typeId: HiveTypeIds.installModelId)
class LlmModelInstall {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int sizeInBytes;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final int installedPercentage;

  @HiveField(4)
  final String url;

  @HiveField(5)
  final ModelInstallStatus installedStatus;

  const LlmModelInstall({
    required this.id,
    required this.sizeInBytes,
    required this.name,
    required this.url,
    required this.installedPercentage,
    required this.installedStatus,
  });

  factory LlmModelInstall.fromJson(Map<String, dynamic> json) {
    return LlmModelInstall(
      id: json['id'] as String,
      installedPercentage: json['installedPercentage'] as int,
      installedStatus: ModelInstallStatus.values.firstWhere(
        (e) => e.name == json['installedStatus'],
        orElse: () => ModelInstallStatus.Queued,
      ),
      name: json['name'] as String,
      sizeInBytes: json['sizeInBytes'] as int,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "installedPercentage": installedPercentage,
      "installedStatus": installedStatus.name,
      "name": name,
      "sizeInBytes": sizeInBytes,
      "url": url,
    };
  }

  factory LlmModelInstall.fromDomain(ModelInstallData data) {
    return LlmModelInstall(
      id: data.id,
      installedPercentage: data.installedPercentage,
      installedStatus: data.installedStatus,
      name: data.name,
      sizeInBytes: data.sizeInBytes,
      url: data.url,
    );
  }

  ModelInstallData toDomain() {
    return ModelInstallData(
      id: id,
      installedPercentage: installedPercentage,
      installedStatus: installedStatus,
      name: name,
      sizeInBytes: sizeInBytes,
      url: url,
    );
  }
}

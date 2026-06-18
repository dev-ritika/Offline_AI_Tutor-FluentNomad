import 'package:hive_ce_flutter/adapters.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_type_ids.dart';
part 'model_install_enum.g.dart';

@HiveType(typeId: HiveTypeIds.installStatusId)
enum ModelInstallStatus {
  @HiveField(0)
  Queued,

  @HiveField(1)
  Downloading,

  @HiveField(2)
  Downloaded,
}

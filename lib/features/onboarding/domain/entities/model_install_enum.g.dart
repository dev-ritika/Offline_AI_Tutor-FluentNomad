// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_install_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelInstallStatusAdapter extends TypeAdapter<ModelInstallStatus> {
  @override
  final typeId = 4;

  @override
  ModelInstallStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ModelInstallStatus.Queued;
      case 1:
        return ModelInstallStatus.Downloading;
      case 2:
        return ModelInstallStatus.Downloaded;
      default:
        return ModelInstallStatus.Queued;
    }
  }

  @override
  void write(BinaryWriter writer, ModelInstallStatus obj) {
    switch (obj) {
      case ModelInstallStatus.Queued:
        writer.writeByte(0);
      case ModelInstallStatus.Downloading:
        writer.writeByte(1);
      case ModelInstallStatus.Downloaded:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelInstallStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_model_install.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LlmModelInstallAdapter extends TypeAdapter<LlmModelInstall> {
  @override
  final typeId = 3;

  @override
  LlmModelInstall read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LlmModelInstall(
      id: fields[0] as String,
      sizeInBytes: (fields[1] as num).toInt(),
      name: fields[2] as String,
      url: fields[4] as String,
      installedPercentage: (fields[3] as num).toInt(),
      installedStatus: fields[5] as ModelInstallStatus,
    );
  }

  @override
  void write(BinaryWriter writer, LlmModelInstall obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sizeInBytes)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.installedPercentage)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.installedStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LlmModelInstallAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

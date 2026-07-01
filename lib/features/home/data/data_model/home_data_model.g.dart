// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeDataModelAdapter extends TypeAdapter<HomeDataModel> {
  @override
  final typeId = 5;

  @override
  HomeDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeDataModel(
      streakDays: (fields[0] as num).toInt(),
      elapsedTimeToday: (fields[1] as num?)?.toInt(),
      lastCompletedDate: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.streakDays)
      ..writeByte(1)
      ..write(obj.elapsedTimeToday)
      ..writeByte(2)
      ..write(obj.lastCompletedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

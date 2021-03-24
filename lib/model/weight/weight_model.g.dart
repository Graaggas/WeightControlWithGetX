// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeightModelAdapter extends TypeAdapter<WeightModel> {
  @override
  final int typeId = 1;

  @override
  WeightModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeightModel()
      .._weightMap = (fields[1] as Map)?.cast<DateTime, double>()
      .._wantedWeight = fields[2] as double
      .._name = fields[3] as String
      ..flagFirstMeeting = fields[4] as bool
      .._startWeightForCalculating = fields[5] as double;
  }

  @override
  void write(BinaryWriter writer, WeightModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj._weightMap)
      ..writeByte(2)
      ..write(obj._wantedWeight)
      ..writeByte(3)
      ..write(obj._name)
      ..writeByte(4)
      ..write(obj.flagFirstMeeting)
      ..writeByte(5)
      ..write(obj._startWeightForCalculating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

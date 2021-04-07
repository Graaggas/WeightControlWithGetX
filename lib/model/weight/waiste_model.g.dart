// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiste_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaisteModelAdapter extends TypeAdapter<WaisteModel> {
  @override
  final int typeId = 2;

  @override
  WaisteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaisteModel()
      .._waisteMap = (fields[1] as Map)?.cast<DateTime, double>()
      .._wantedWaiste = fields[2] as double
      .._name = fields[3] as String
      ..flagFirstMeeting = fields[4] as bool
      .._startWaisteForCalculating = fields[5] as double
      .._height = fields[6] as double;
  }

  @override
  void write(BinaryWriter writer, WaisteModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj._waisteMap)
      ..writeByte(2)
      ..write(obj._wantedWaiste)
      ..writeByte(3)
      ..write(obj._name)
      ..writeByte(4)
      ..write(obj.flagFirstMeeting)
      ..writeByte(5)
      ..write(obj._startWaisteForCalculating)
      ..writeByte(6)
      ..write(obj._height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaisteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

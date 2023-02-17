// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskObjectAdapter extends TypeAdapter<TaskObject> {
  @override
  final int typeId = 0;

  @override
  TaskObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskObject(
      title: fields[1] as String,
      done: fields[2] as bool,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, TaskObject obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

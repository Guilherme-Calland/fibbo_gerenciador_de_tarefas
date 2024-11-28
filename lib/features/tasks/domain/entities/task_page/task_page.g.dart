// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskPageAdapter extends TypeAdapter<TaskPage> {
  @override
  final int typeId = 0;

  @override
  TaskPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskPage(
      tasks: (fields[0] as List).cast<TaskModel>(),
      isLastPage: fields[1] as bool,
      total: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TaskPage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tasks)
      ..writeByte(1)
      ..write(obj.isLastPage)
      ..writeByte(2)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

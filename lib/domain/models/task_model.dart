import 'package:flutter_poc/data/network/dtos/task_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';

@freezed
sealed class TaskModel with _$TaskModel {
  factory TaskModel({
    required String id,
    required DateTime createdAt,
    required String name,
    required bool done,
  }) = _TaskModel;

  factory TaskModel.fromDTO(TaskDTO dto) => TaskModel(
        id: dto.id,
        createdAt: DateTime.parse(dto.createdAt),
        name: dto.name,
        done: dto.done,
      );
}

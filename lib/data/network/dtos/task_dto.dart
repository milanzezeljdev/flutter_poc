import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
sealed class TaskDTO with _$TaskDTO {
  factory TaskDTO({
    required String id,
    required String createdAt,
    required String name,
    required bool done,
  }) = _TaskDTO;

  factory TaskDTO.fromJson(Map<String, dynamic> json) =>
      _$TaskDTOFromJson(json);
}

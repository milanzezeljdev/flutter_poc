import 'package:flutter_poc/data/network/dtos/task_dto.dart';
import 'package:flutter_poc/domain/models/utils/failure_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TaskRepository {
  TaskEither<Failure, List<TaskDTO>> getTasks();
  TaskEither<Failure, void> editTask({
    required String id,
    required bool isFinished,
  });
}

import 'package:flutter_poc/data/network/repositories/task_repository_impl.dart';
import 'package:flutter_poc/domain/models/task_model.dart';
import 'package:flutter_poc/domain/models/utils/failure_model.dart';
import 'package:flutter_poc/domain/repositories/task_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_service.g.dart';

@riverpod
TaskService taskService(Ref ref) =>
    TaskService(ref.read(taskRepositoryProvider));

class TaskService {
  final TaskRepository _taskRepository;

  const TaskService(this._taskRepository);

  Future<Either<Failure, List<TaskModel>>> getTasks() async {
    final response = await _taskRepository.getTasks().run();

    return response.map(
      (dtoList) => dtoList.map((dto) => TaskModel.fromDTO(dto)).toList(),
    );
  }

  Future<Either<Failure, void>> editTask({
    required String id,
    required bool isFinished,
  }) async =>
      await _taskRepository.editTask(id: id, isFinished: isFinished).run();
}

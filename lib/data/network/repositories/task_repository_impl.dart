import 'package:dio/dio.dart';
import 'package:flutter_poc/core/error_handler.dart';
import 'package:flutter_poc/data/network/dio.dart';
import 'package:flutter_poc/data/network/dtos/task_dto.dart';
import 'package:flutter_poc/domain/models/utils/failure_model.dart';
import 'package:flutter_poc/domain/repositories/task_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_repository_impl.g.dart';

@riverpod
TaskRepository taskRepository(Ref ref) =>
    _TaskRepositoryImpl(ref.read(dioProvider));

class _TaskRepositoryImpl implements TaskRepository {
  final Dio _dio;

  const _TaskRepositoryImpl(this._dio);
  @override
  TaskEither<Failure, List<TaskDTO>> getTasks() {
    return TaskEither.tryCatch(
      () async {
        final endpoint = "/tasks";

        final response = await _dio.get(endpoint);
        List<dynamic> data = response.data;

        return data
            .map((e) => TaskDTO.fromJson(e as Map<String, dynamic>))
            .toList();
      },
      ErrorHandler.handle,
    );
  }
}

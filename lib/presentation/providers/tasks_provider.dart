import 'package:flutter_poc/domain/models/task_model.dart';
import 'package:flutter_poc/domain/services/task_service.dart';
import 'package:flutter_poc/presentation/providers/state/provider_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_provider.g.dart';

@riverpod
class Tasks extends _$Tasks {
  @override
  ProviderState<List<TaskModel>> build() {
    _getTasks();
    return ProviderState.initial();
  }

  Future<void> refresh() async => await _getTasks(shouldLoad: false);

  Future<void> _getTasks({bool shouldLoad = true}) async {
    if (shouldLoad) state = ProviderState.loading();
    final service = ref.read(taskServiceProvider);

    final response = await service.getTasks();

    state = response.fold(
      (error) => ProviderState.error(error),
      (tasks) {
        if (tasks.isEmpty) return ProviderState.empty();
        return ProviderState.success(tasks);
      },
    );
  }
}

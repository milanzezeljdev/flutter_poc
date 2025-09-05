import 'package:flutter_poc/domain/services/task_service.dart';
import 'package:flutter_poc/presentation/providers/state/provider_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'finish_task_provider.g.dart';

@riverpod
class FinishTask extends _$FinishTask {
  @override
  ProviderState<void> build(String taskId) {
    return ProviderState.initial();
  }

  Future<void> finishTask() async {
    state = ProviderState.loading();
    final service = ref.read(taskServiceProvider);

    final response = await service.editTask(id: taskId, isFinished: true);

    state = response.fold(
      (failure) => ProviderState.error(failure),
      (_) => ProviderState.success(null),
    );
  }

  Future<void> undoTask() async {
    state = ProviderState.loading();

    final service = ref.read(taskServiceProvider);
    final response = await service.editTask(id: taskId, isFinished: true);

    state = response.fold(
      (failure) => ProviderState.error(failure),
      (_) => ProviderState.success(null),
    );
  }
}

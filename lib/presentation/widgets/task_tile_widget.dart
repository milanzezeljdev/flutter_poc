import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_poc/domain/models/task_model.dart';
import 'package:flutter_poc/presentation/providers/finish_task_provider.dart';
import 'package:flutter_poc/presentation/providers/state/provider_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskTile extends HookConsumerWidget {
  final TaskModel task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checked = useState(task.done);
    final finishTaskNotifier = ref.read(finishTaskProvider(task.id).notifier);
    final finishTaskState = ref.watch(finishTaskProvider(task.id));

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.name),
                  Text(task.createdAt.toString()),
                ],
              ),
            ),
            finishTaskState.maybeWhen(
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
              orElse: () => Checkbox(
                value: checked.value,
                onChanged: (value) {
                  checked.value = value!;
                  if (value) {
                    finishTaskNotifier.finishTask();
                  } else {
                    finishTaskNotifier.undoTask();
                  }
                },
                tristate: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

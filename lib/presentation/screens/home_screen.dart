import 'package:flutter/material.dart';
import 'package:flutter_poc/core/context_extension.dart';
import 'package:flutter_poc/presentation/providers/state/provider_state.dart';
import 'package:flutter_poc/presentation/providers/tasks_provider.dart';
import 'package:flutter_poc/presentation/widgets/task_tile_widget.dart';
import 'package:flutter_poc/presentation/widgets/utils/pull_to_refresh_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = context.localization;
    final tasksProviderState = ref.watch(tasksProvider);
    final tasksNotifier = ref.read(tasksProvider.notifier);

    return Scaffold(
      body: PullToRefresh(
        topOffset: MediaQuery.paddingOf(context).top,
        onRefresh: tasksNotifier.refresh,
        slivers: tasksProviderState.maybeWhen(
          success: (tasks) => [
            SliverList.separated(
              itemBuilder: (context, index) => TaskTile(task: tasks[index]),
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemCount: tasks.length,
            ),
          ],
          empty: () => [
            SliverFillRemaining(
              child: Center(child: Text(localization.noAvailableTasks)),
            ),
          ],
          orElse: () => [
            SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

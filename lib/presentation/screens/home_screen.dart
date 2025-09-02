import 'package:flutter/material.dart';
import 'package:flutter_poc/presentation/providers/state/provider_state.dart';
import 'package:flutter_poc/presentation/providers/tasks_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksProviderState = ref.watch(tasksProvider);

    return Scaffold(
      body: tasksProviderState.maybeWhen(
        success: (tasks) => ListView.separated(
          itemBuilder: (context, index) => Text(tasks[index].name),
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemCount: tasks.length,
        ),
        orElse: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

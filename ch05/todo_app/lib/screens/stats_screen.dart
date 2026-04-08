import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/todos_provider.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    final completedTodos = todos.where((todo) => todo.isCompleted).toList();
    final categories = ref.read(categoriesProvider);

    final completeRate = todos.isEmpty
        ? 0.0
        : completedTodos.length / todos.length * 100;

    final categoryStats = <String, int>{};
    for (final category in categories) {
      categoryStats[category] = todos
          .where((todo) => todo.category == category)
          .length;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("통계")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "전체 요약",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    _buildStatItem("전체 할 일", todos.length.toString()),
                    _buildStatItem("완료한 할 일", completedTodos.length.toString()),
                    _buildStatItem(
                      "진행 중인 할 일",
                      (todos.length - completedTodos.length).toString(),
                    ),
                    _buildStatItem(
                      "완료율",
                      "${completeRate.toStringAsFixed(1)}%",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text("카테고리별 통계", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: categoryStats.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final count = categoryStats[category] ?? 0;
                  return Card(
                    child: ListTile(
                      title: Text(category),
                      trailing: Text(
                        count.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

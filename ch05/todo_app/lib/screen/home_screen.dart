import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/providers/todo_providers.dart';
import 'package:todo_app/widgets/todo_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String filter = "all";

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(getTodosByFilterProvider(filter));
    final todoNotifier = ref.read(todoProvider.notifier);
    final categories = ref.read(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("할 일 목록"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "all", child: Text("모든 할 일")),
              const PopupMenuItem(value: "completed", child: Text("완료된 할 일")),
              const PopupMenuItem(value: "active", child: Text("미완료된 할 일")),
              for (final category in categories)
                PopupMenuItem(value: category.$1, child: Text(category.$2)),
            ],
          ),
        ],
      ),
      body: todos.isEmpty
          ? const Center(child: Text("할 일이 없습니다. 새 할 일을 추가해보세요!"))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: () => todoNotifier.toggleTogo(todo.id),
                  onTab: () => context.go("/todo/${todo.id}"),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go("/add"),
        child: const Icon(Icons.add),
      ),
    );
  }
}

@Preview(group: "screen", name: "HomeScreen", size: Size(480, 800))
Widget previewHomeScreen() => ProviderScope(child: const HomeScreen());

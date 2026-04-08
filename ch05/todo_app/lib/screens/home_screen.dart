import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/widget/todo_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosNotifier = ref.watch(todosProvider.notifier);
    final todos = ref.watch(filterTodoProvider);
    final filterNotifier = ref.watch(filterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("할 일 목록"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              filterNotifier.setFilter(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "all", child: Text("모든 할 일")),
              const PopupMenuItem(value: "completed", child: Text("완료된 할 일")),
              const PopupMenuItem(value: "active", child: Text("미완료인 할 일")),
              const PopupMenuItem(value: "general", child: Text("일반")),
              const PopupMenuItem(value: "work", child: Text("업무")),
              const PopupMenuItem(value: "personal", child: Text("개인")),
              const PopupMenuItem(value: "shopping", child: Text("쇼핑")),
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
                  onTap: () => context.go("/todo/${todo.id}"),
                  onToggle: () => todosNotifier.toggleTodo(todo.id),
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

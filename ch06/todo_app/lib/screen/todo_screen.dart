import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/component/todo_item.dart';
import 'package:todo_app/model/todo_view_model.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final todosNotifier = ref.watch(todoProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("할 일 목록")),
      body: todos.when(
        data: (todos) => todos.isEmpty
            ? const Center(child: Text("할 일이 없습니다."))
            : ListView.builder(
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoItem(
                    todo: todo,
                    onToggle: () => todosNotifier.toggleTodoCompleted(todo),
                    onDelete: () => todosNotifier.deleteTodo(todo.id),
                  );
                },
                itemCount: todos.length,
              ),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("오류: $error", style: TextStyle(color: Colors.red)),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => todosNotifier.fetchTodos(),
                child: const Text("다시 시도"),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context, todosNotifier),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoNotifier todosNotifier) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("새 할 일 추가"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "제목"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "설명"),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("취소"),
          ),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text.trim();
              final description = descriptionController.text.trim();

              if (title.isNotEmpty) {
                todosNotifier.createTodo(title, description);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("제목이 비어 있습니다")));
              }
            },
            child: const Text("추가"),
          ),
        ],
      ),
    );
  }
}

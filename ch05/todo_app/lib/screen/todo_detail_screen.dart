import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/providers/todo_providers.dart';

class TodoDetailScreen extends ConsumerWidget {
  final String todoId;

  const TodoDetailScreen({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(getTodoByIdProvider(todoId));
    final todoNotifier = ref.read(todoProvider.notifier);

    if (todo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("할 일 없음")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("요청한 할 일을 찾을 수 없습니다."),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => context.go("/"),
              child: const Text("홈으로 돌아가기"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("할 일 상세"),
        actions: [
          // 편집 버튼
          IconButton(
            onPressed: () => context.go("/edit/${todo.id}"),
            icon: const Icon(Icons.edit),
          ),
          // 삭제 버튼
          IconButton(
            onPressed: () {
              todoNotifier.deleteTodo(todo.id);
              context.go("/");
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text(todo.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8.0),
            // 내용
            Chip(
              label: Text(todo.category),
              backgroundColor: Colors.blue.shade100,
            ),
            const SizedBox(height: 16.0),
            // 생성 날짜
            Text(
              "생성일: ${_formatDate(todo.createdAt)}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),
            // 상태
            Row(
              children: [
                const Text("상태: "),
                Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => todoNotifier.toggleTogo(todo.id),
                ),
                Text(todo.isCompleted ? "완료" : "미완료"),
              ],
            ),
            const SizedBox(height: 8.0),
            // 설명
            const Text("설명:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                todo.description.isEmpty ? "(설명 없음)" : todo.description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  return "${date.year}년 ${date.month}월 ${date.day}일";
}

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          color: todo.isCompleted ? Colors.grey : null,
        ),
      ),
      subtitle: Text(
        "카테고리: ${todo.category}",
        style: TextStyle(
          color: todo.isCompleted ? Colors.grey : Colors.black54,
        ),
      ),
      leading: Checkbox(value: todo.isCompleted, onChanged: (_) => onToggle()),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

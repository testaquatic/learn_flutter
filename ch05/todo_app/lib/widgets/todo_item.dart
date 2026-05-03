import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onTab;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onTab,
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
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (context) => onToggle(),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTab,
    );
  }
}

@Preview(group: "widget", name: "TodoItem", size: Size.fromWidth(480))
Widget previewTodoItem() => TodoItem(
  onTab: () {},
  onToggle: () {},
  todo: Todo(title: "이게!", description: "뭐지!", isCompleted: false),
);

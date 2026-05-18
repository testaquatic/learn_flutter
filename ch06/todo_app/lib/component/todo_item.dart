import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? Colors.grey : null,
          ),
        ),
        subtitle: todo.description.isNotEmpty ? Text(todo.description) : null,
        leading: Checkbox(value: todo.completed, onChanged: (_) => onToggle()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (todo.priority == "high")
              Icon(Icons.priority_high, color: Colors.red),
            Text(
              DateFormat.yMMMd().format(todo.createdAt),
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

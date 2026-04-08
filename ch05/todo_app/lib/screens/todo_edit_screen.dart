import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';

class TodoEditScreen extends ConsumerStatefulWidget {
  final String? todoId;

  const TodoEditScreen({super.key, this.todoId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TodoEditScreenState();
  }
}

class _TodoEditScreenState extends ConsumerState<TodoEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _category = "general";
  bool _isCompleted = false;

  Todo? get getTodo => widget.todoId != null
      ? ref.read(todosProvider.notifier).getTodayById(widget.todoId!)
      : null;

  @override
  void initState() {
    super.initState();

    final todo = getTodo;

    _titleController = TextEditingController(text: todo?.title ?? "");
    _descriptionController = TextEditingController(
      text: todo?.description ?? "",
    );
    _category = todo?.category ?? "general";
    _isCompleted = todo?.isCompleted ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      final todoNotifier = ref.read(todosProvider.notifier);
      final todo = getTodo;

      if (todo == null) {
        final newTodo = Todo(
          title: _titleController.text,
          description: _descriptionController.text,
          category: _category,
          isCompleted: _isCompleted,
        );
        todoNotifier.addTodo(newTodo);
      } else {
        final updateTodo = Todo(
          id: todo.id,
          title: _titleController.text,
          description: _descriptionController.text,
          category: _category,
          isCompleted: _isCompleted,
          createdAt: todo.createdAt,
        );
        todoNotifier.updateTodo(updateTodo);
      }
    }

    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.read(categoriesProvider);
    final todo = getTodo;

    return Scaffold(
      appBar: AppBar(title: Text(todo == null ? "할 일 추가" : "할 일 편집")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "제목",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "제목을 입력해주세요.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "설명",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "카테고리",
                  border: OutlineInputBorder(),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTodo,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    todo == null ? "추가하기" : "수정하기",
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});
}

class TotoListModel extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(String title) {
    if (title.isNotEmpty) {
      _todos.add(Todo(title: title));
      notifyListeners();
    }
  }

  void toggleTodo(int index) {
    if (index >= 0 && index < _todos.length) {
      _todos[index].completed = !_todos[index].completed;
      notifyListeners();
    }
  }

  void removeTodo(int index) {
    if (index >= 0 && index < _todos.length) {
      _todos.removeAt(index);
      notifyListeners();
    }
  }
}

class TodoListWithValueNotifier extends StatefulWidget {
  const TodoListWithValueNotifier({super.key});

  @override
  State<TodoListWithValueNotifier> createState() =>
      _TodoListWithValueNotifierState();
}

class _TodoListWithValueNotifierState extends State<TodoListWithValueNotifier> {
  final TotoListModel _model = TotoListModel();
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    _model.addTodo(_controller.text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("할 일 목록 (ValueNotifier)")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "할 일 추가",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(onPressed: _addTodo, child: const Text("추가")),
              ],
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _model,
              builder: (context, child) {
                return ListView.builder(
                  itemCount: _model.todos.length,
                  itemBuilder: (context, index) {
                    final todo = _model.todos[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => _model.toggleTodo(index),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () => _model.removeTodo(index),
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: TodoListWithValueNotifier()));
}

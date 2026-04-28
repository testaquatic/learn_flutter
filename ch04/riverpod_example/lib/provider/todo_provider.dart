import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/model/todo.dart';
import 'package:uuid/uuid.dart';

final todoListProvider = NotifierProvider<TodoList, List<Todo>>(TodoList.new);

class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [];
  }

  void addTodo(String title) {
    final newTodo = Todo(id: const Uuid().v4(), title: title);

    state = [...state, newTodo];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final completedTodosCountProvider = Provider<int>((ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => todo.completed).length;
});

final uncompletedTodosCountProvider = Provider<int>((ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => !todo.completed).length;
});

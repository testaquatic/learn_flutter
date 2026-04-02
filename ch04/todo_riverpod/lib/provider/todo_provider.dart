import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/model/todo.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
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

@riverpod
int completedTodosCount(Ref ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => todo.completed).length;
}

@riverpod
int uncompletedTodosCount(Ref ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => !todo.completed).length;
}

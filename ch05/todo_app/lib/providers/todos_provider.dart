import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/models/todo.dart';

part 'todos_provider.g.dart';

@riverpod
class Todos extends _$Todos {
  @override
  List<Todo> build() => <Todo>[];

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void updateTodo(Todo newTodo) {
    state = state.map((todo) {
      if (todo.id == newTodo.id) {
        return newTodo;
      }
      return todo;
    }).toList();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
  }

  Todo? getTodayById(String id) {
    try {
      return state.firstWhere((todo) => todo.id == id);
    } catch (e) {
      return null;
    }
  }
}

@riverpod
class Filter extends _$Filter {
  @override
  String build() => "all";

  String get filter => state;

  void setFilter(String filter) {
    state = filter;
  }
}

@riverpod
class Categories extends _$Categories {
  @override
  List<String> build() => ["general", "work", "personal", "shopping"];
}

@riverpod
List<Todo> filterTodo(Ref ref) {
  final filter = ref.watch(filterProvider);
  final todos = ref.watch(todosProvider);

  switch (filter) {
    case "all":
      return todos;
    case "completed":
      return todos.where((todo) => todo.isCompleted).toList();
    case "active":
      return todos.where((todo) => !todo.isCompleted).toList();
    default:
      return todos.where((todo) => todo.category == filter).toList();
  }
}

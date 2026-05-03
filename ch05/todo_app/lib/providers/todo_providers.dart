import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';

/// todo의 전체 목록을 제공한다.
final todoProvider = NotifierProvider(TodoNotifier.new);

/// 카테고리 목록을 제공한다.
final categoryProvider = Provider<List<(String, String)>>(
  (ref) => [
    ("general", "일반"),
    ("work", "업무"),
    ("personal", "개인"),
    ("shopping", "쇼핑"),
  ],
);

/// id를 기준으로 일정을 조회한다.
final getTodoByIdProvider = Provider.family<Todo?, String>((ref, id) {
  final todos = ref.watch(todoProvider);
  try {
    return todos.firstWhere((todo) => todo.id == id);
  } on StateError {
    return null;
  }
});

/// 필터를 기준으로 일정의 목록을 반환한다.
/// "all"과 "completed", "active"의 경우에는 완료 여부가 기준이고
/// 나머지는 category가 기준이다.
final getTodosByFilterProvider = Provider.family<List<Todo>, String>((
  ref,
  filter,
) {
  final todos = ref.watch(todoProvider);
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
});

class FilterNotifier extends Notifier<String> {
  @override
  String build() {
    return "all";
  }

  void setFilter(String filter) {
    state = filter;
  }
}

class TodoNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [];
  }

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void updateTodo(Todo todo) {
    state = state.map((t) => t.id == todo.id ? todo : t).toList();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTogo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
  }
}

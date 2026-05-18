import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/todo_repository.dart';

final todoProvider = AsyncNotifierProvider(TodoNotifier.new);

class TodoNotifier extends AsyncNotifier<List<Todo>> {
  late TodoRepository _todoRepository;

  @override
  FutureOr<List<Todo>> build() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.1.173:3000/",
        connectTimeout: Duration(seconds: 5),
      ),
    );
    dio.interceptors.add(LogInterceptor(requestBody: true));

    _todoRepository = TodoRepository(dio);

    state = const AsyncValue.loading();
    try {
      final todos = await _todoRepository.getTodos();
      return todos;
    } catch (e) {
      state = AsyncValue.error(
        Exception("할 일을 가져오는데 실패했습니다: $e"),
        StackTrace.current,
      );
      return [];
    }
  }

  Future<void> fetchTodos() async {
    state = const AsyncValue.loading();
    try {
      final todos = await _todoRepository.getTodos();
      state = AsyncValue.data(todos);
    } catch (e) {
      state = AsyncValue.error(
        Exception("할 일을 가져오는데 실패했습니다: $e"),
        StackTrace.current,
      );
    }
  }

  Future<void> createTodo(String title, String description) async {
    try {
      final newTodo = Todo.create(title: title, description: description);
      await _todoRepository.createTodo(newTodo);
      await fetchTodos();
    } catch (e) {
      state = AsyncValue.error(
        Exception("할 일을 생성하는데 실패했습니다: $e"),
        StackTrace.current,
      );
    }
  }

  Future<void> toggleTodoCompleted(Todo todo) async {
    try {
      final updatedTodo = todo.copyWith(
        completed: !todo.completed,
        updatedAt: DateTime.now(),
      );
      await _todoRepository.updateTodo(updatedTodo);
      await fetchTodos();
    } catch (e) {
      state = AsyncValue.error(
        Exception("할 일 상태를 변경하는데 실패했습니다: $e"),
        StackTrace.current,
      );
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoRepository.deleteTodo(id);
      await fetchTodos();
    } catch (e) {
      state = AsyncValue.error(
        Exception("할 일을 삭제하는데 실패했습니다: $e"),
        StackTrace.current,
      );
    }
  }
}

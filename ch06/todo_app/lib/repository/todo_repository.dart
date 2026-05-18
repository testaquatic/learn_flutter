import 'package:dio/dio.dart';
import 'package:todo_app/model/todo.dart';

class TodoRepository {
  final Dio _dio;

  TodoRepository(this._dio);

  Future<List<Todo>> getTodos() async {
    try {
      final response = await _dio.get("/todos");
      return (response.data as List)
          .map((json) => Todo.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("할 일 목록을 가져오는데 실패했습니다: $e");
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    try {
      final response = await _dio.post("/todos", data: todo.toJson());
      return Todo.fromJson(response.data);
    } catch (e) {
      throw Exception("할 일을 생성하는데 실패했습니다: $e");
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    try {
      final response = await _dio.put("/todos/${todo.id}", data: todo.toJson());

      return Todo.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception("할 일을 업데이트 하는데 실패했습니다: $e");
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _dio.delete("/todos/$id");
    } catch (e) {
      throw Exception("할 일을 삭제하는데 실패했습니다: $e");
    }
  }
}

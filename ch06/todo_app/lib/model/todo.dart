import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@Freezed()
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    @Default("") String description,
    @Default(false) bool completed,
    @JsonKey(
      name: "created_at",
      toJson: _datetimeToJson,
      fromJson: _jsonToDateTime,
    )
    required DateTime createdAt,
    @JsonKey(
      name: "updated_at",
      toJson: _datetimeNullToJson,
      fromJson: _jsonToDateTimeNull,
      explicitJsonNullWhenNonNullField: true,
    )
    @JsonKey(name: "updated_at", includeIfNull: false)
    DateTime? updatedAt,
    @Default("normal") String priority,
    @Default([]) List<String> tags,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  factory Todo.create({
    required String title,
    String description = "",
    String priority = "normal",
    List<String> tags = const [],
  }) {
    return Todo(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      priority: priority,
      tags: tags,
    );
  }
}

String _datetimeToJson(DateTime date) => date.toUtc().toIso8601String();

DateTime _jsonToDateTime(String date) => DateTime.parse(date).toLocal();
String? _datetimeNullToJson(DateTime? date) => date?.toUtc().toIso8601String();

DateTime? _jsonToDateTimeNull(String? date) =>
    date == null ? null : DateTime.parse(date).toLocal();

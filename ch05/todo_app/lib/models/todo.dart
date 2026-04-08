import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final String category;

  Todo({
    String? id,
    required this.title,
    this.description = "",
    this.isCompleted = false,
    DateTime? createdAt,
    this.category = "general",
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  Todo copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    String? category,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      category: category ?? this.category,
    );
  }
}

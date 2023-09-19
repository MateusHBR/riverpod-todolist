// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

import 'package:hello_riverpod/entity/todo.dart';

part 'todo_schema.g.dart';

@collection
class TodoSerializer {
  TodoSerializer({
    required this.todoId,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory TodoSerializer.fromEntity(Todo entity) {
    return TodoSerializer(
      todoId: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
    );
  }

  Id id = Isar.autoIncrement;

  @Index()
  final String todoId;

  final String title;
  final String description;
  final bool isCompleted;

  TodoSerializer copyWith({
    String? todoId,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoSerializer(
      todoId: todoId ?? this.todoId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Todo toEntity() {
    return Todo(
      id: todoId,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }

  @override
  String toString() {
    return 'TodoSerializer(id: $id, todoId: $todoId, title: $title, description: $description, isCompleted: $isCompleted)';
  }
}

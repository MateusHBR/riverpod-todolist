import 'package:equatable/equatable.dart';

final class Todo extends Equatable {
  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  @override
  List<Object> get props => [
        title,
        description,
        isCompleted,
      ];

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Todo { id: $id, title: $title, description: $description, isCompleted: $isCompleted }';
  }
}

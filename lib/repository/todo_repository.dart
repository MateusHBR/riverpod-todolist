import 'package:hello_riverpod/repository/schemas/todo_schema.dart';
import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hello_riverpod/entity/todo.dart';
import 'package:hello_riverpod/main.dart';

final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(
    isar: ref.watch(isarProvider),
  ),
);

abstract interface class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<void> addNewTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
}

final class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl({
    required this.isar,
  });

  final Isar isar;

  @override
  Future<void> addNewTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todoSerializers.put(
        TodoSerializer.fromEntity(todo),
      );
    });
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todoSerializers.filter().todoIdEqualTo(todo.id).deleteFirst();
    });
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    final todos = await isar.todoSerializers.where().findAll();
    return todos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await isar.writeTxn(() async {
      final todoToUpdate =
          await isar.todoSerializers.where().todoIdEqualTo(todo.id).findFirst();

      if (todoToUpdate == null) return;
      await isar.todoSerializers.put(
        TodoSerializer.fromEntity(todo)..id = todoToUpdate.id,
      );
    });
  }
}

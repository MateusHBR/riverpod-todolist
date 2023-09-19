import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_riverpod/entity/todo.dart';
import 'package:hello_riverpod/repository/todo_repository.dart';
import 'package:uuid/uuid.dart';

enum FilterState {
  all(label: 'All'),
  completed(label: 'Completed'),
  uncompleted(label: 'Uncompleted');

  const FilterState({required this.label});

  final String label;
}

final homeFilterProvider = StateProvider(
  (ref) => FilterState.all,
);

final homeProvider = StateNotifierProvider<HomeProvider, List<Todo>>(
  (ref) => HomeProvider(
    todoRepository: ref.watch(todoRepositoryProvider),
  ),
);

final homeFilteredListProvider = StateProvider(
  (ref) {
    final filter = ref.watch(homeFilterProvider);
    final todos = ref.watch(homeProvider);

    return switch (filter) {
      FilterState.all => todos,
      FilterState.completed => todos.where((todo) => todo.isCompleted).toList(),
      FilterState.uncompleted =>
        todos.where((todo) => !todo.isCompleted).toList(),
    };
  },
);

final class HomeProvider extends StateNotifier<List<Todo>> {
  HomeProvider({
    required this.todoRepository,
  }) : super([]);

  final TodoRepository todoRepository;

  Future<void> initialize() async {
    final todos = await todoRepository.fetchTodos();
    state = todos;
  }

  Future<void> add({required String name}) async {
    final todo = Todo(
      id: const Uuid().v4(),
      title: name,
      description: '',
      isCompleted: false,
    );
    await todoRepository.addNewTodo(todo);

    state = [
      ...state,
      todo,
    ];
  }

  Future<void> toggle(String todoId) async {
    final todoIndex = state.indexWhere((todo) => todo.id == todoId);
    if (todoIndex < 0) return;

    final todo = state[todoIndex];
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
    );
    await todoRepository.updateTodo(updatedTodo);

    state = [
      ...state.sublist(0, todoIndex),
      updatedTodo,
      ...state.sublist(todoIndex + 1),
    ];
  }

  Future<void> remove(String todoId) async {
    final todoIndex = state.indexWhere((todo) => todo.id == todoId);
    if (todoIndex < 0) return;

    await todoRepository.deleteTodo(state[todoIndex]);
    state = [
      ...state.sublist(0, todoIndex),
      ...state.sublist(todoIndex + 1),
    ];
  }
}

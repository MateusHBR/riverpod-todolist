import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_riverpod/entity/todo.dart';
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
  (ref) => HomeProvider(),
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
  HomeProvider() : super([]);

  void add({required String name}) {
    state = [
      ...state,
      Todo(
        id: const Uuid().v4(),
        title: name,
        description: '',
        isCompleted: false,
      ),
    ];
  }

  void toggle(String todoId) {
    final todoIndex = state.indexWhere((todo) => todo.id == todoId);
    if (todoIndex < 0) return;

    final todo = state[todoIndex];
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
    );

    state = [
      ...state.sublist(0, todoIndex),
      updatedTodo,
      ...state.sublist(todoIndex + 1),
    ];
  }

  void remove(String todoId) {
    state = state.where((todo) => todo.id != todoId).toList();
  }
}

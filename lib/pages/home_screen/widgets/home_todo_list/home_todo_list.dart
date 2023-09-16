import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_riverpod/pages/home_screen/home_provider.dart';

class HomeTodoList extends ConsumerWidget {
  const HomeTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(homeFilteredListProvider);

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final item = todos[index];

        void toggle() => ref.read(homeProvider.notifier).toggle(
              item.id,
            );

        void remove() => ref.read(homeProvider.notifier).remove(
              item.id,
            );

        return Dismissible(
          background: const ColoredBox(color: Colors.red),
          key: Key('ITEM${item.id}'),
          onDismissed: (_) => remove(),
          child: ListTile(
            onTap: toggle,
            title: Text(
              item.title,
              style: TextStyle(
                color: item.isCompleted ? Colors.grey : Colors.black,
                decoration:
                    item.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              item.description,
            ),
            trailing: Checkbox(
              value: item.isCompleted,
              onChanged: (_) => toggle(),
            ),
          ),
        );
      },
    );
  }
}

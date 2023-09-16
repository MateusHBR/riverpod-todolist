import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_riverpod/pages/home_screen/widgets/filter_section/filter_section.dart';

import 'home_provider.dart';
import 'widgets/home_todo_list/home_todo_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _fieldTextController = TextEditingController();

  @override
  void dispose() {
    _fieldTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fieldTextController,
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: _fieldTextController,
                    builder: (context, state, _) {
                      final hasText = state.text.isNotEmpty;

                      return IconButton(
                        onPressed: hasText
                            ? () {
                                ref.read(homeProvider.notifier).add(
                                      name: state.text,
                                    );
                                _fieldTextController.clear();
                              }
                            : null,
                        icon: const Icon(Icons.add),
                      );
                    }),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: FilterSection(),
          ),
          const Expanded(
            child: HomeTodoList(),
          ),
        ],
      ),
    );
  }
}

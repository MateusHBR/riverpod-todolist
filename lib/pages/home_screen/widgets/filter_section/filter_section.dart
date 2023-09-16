import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_riverpod/pages/home_screen/home_provider.dart';

part 'filter.dart';

class FilterSection extends ConsumerWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        Filter(filter: FilterState.all),
        SizedBox(width: 8),
        Filter(filter: FilterState.completed),
        SizedBox(width: 8),
        Filter(filter: FilterState.uncompleted),
      ],
    );
  }
}

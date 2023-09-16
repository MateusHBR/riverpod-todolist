part of 'filter_section.dart';

class Filter extends ConsumerWidget {
  const Filter({
    super.key,
    required this.filter,
  });

  final FilterState filter;

  void _onTap(WidgetRef ref) {
    ref.read(homeFilterProvider.notifier).state = filter;
  }

  MaterialStateProperty<MaterialColor> _getColor(FilterState selectedFilter) {
    if (filter == selectedFilter) {
      return MaterialStateProperty.all(Colors.deepPurple);
    }

    return MaterialStateProperty.all(Colors.grey);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(homeFilterProvider);

    return InkWell(
      onTap: () => _onTap(ref),
      child: Chip(
        color: _getColor(selectedFilter),
        label: Text(filter.label),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          filterSwitchWidget(
              context, ref, activeFilters, Filter.glutenFree, 'Gluten-free'),
          filterSwitchWidget(
              context, ref, activeFilters, Filter.lactoseFree, 'Lactose-free'),
          filterSwitchWidget(
              context, ref, activeFilters, Filter.vegetarian, 'Vegetarian'),
          filterSwitchWidget(
              context, ref, activeFilters, Filter.vegan, 'Vegan'),
        ],
      ),
    );
  }

  SwitchListTile filterSwitchWidget(BuildContext context, WidgetRef ref,
      Map<Filter, bool> activeFilters, Filter filter, final String title) {
    return SwitchListTile(
      value: activeFilters[filter]!,
      onChanged: (isChecked) {
        ref.read(filterProvider.notifier).setFilter(filter, isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        "Only include ${title.toLowerCase()} meals. ",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}

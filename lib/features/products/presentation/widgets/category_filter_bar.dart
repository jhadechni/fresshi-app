import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresshi/core/utils/string_extensions.dart';
import 'package:fresshi/features/products/presentation/providers/products_provider.dart';
import 'package:fresshi/shared/ui/theme/app_colors.dart';

class CategoryFilterBar extends ConsumerWidget {
  const CategoryFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selected = ref.watch(selectedCategoryProvider);

    return categoriesAsync.when(
      loading: () => const SizedBox(
        height: 48,
        child: Center(child: LinearProgressIndicator()),
      ),
      error: (error, _) => const SizedBox.shrink(),
      data: (categories) => SizedBox(
        height: 48,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label:  Text('All', style: TextStyle(
                  color: selected == null ? 
                   AppColors.textOnPrimary: AppColors.textPrimary
                ),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                selected: selected == null,
                onSelected: (_) =>
                    ref.read(selectedCategoryProvider.notifier).state = null,
              ),
            ),
            ...categories.map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(category.capitalize, style: TextStyle(
                    color: selected == category ? 
                     AppColors.textOnPrimary: AppColors.textPrimary
                  ),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  selected: selected == category,
                  onSelected: (_) =>
                      ref.read(selectedCategoryProvider.notifier).state =
                          category,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

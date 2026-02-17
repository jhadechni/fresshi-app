import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/features/products/presentation/providers/products_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();
  final productsAsync = ref.watch(productsProvider);

  if (query.isEmpty) return const AsyncValue.data([]);

  return productsAsync.whenData(
    (products) => products
        .where(
          (p) =>
              p.title.toLowerCase().contains(query) ||
              p.description.toLowerCase().contains(query) ||
              p.category.toLowerCase().contains(query),
        )
        .toList(),
  );
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fresshi/routes/app_routes.dart';
import 'package:fresshi/features/products/presentation/providers/products_provider.dart';
import 'package:fresshi/features/products/presentation/widgets/product_card.dart';
import 'package:fresshi/features/products/presentation/widgets/category_filter_bar.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(filteredProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search products',
            onPressed: () => context.pushNamed(AppRoutes.searchName),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Cart',
            onPressed: () => context.pushNamed(AppRoutes.cartName),
          ),
        ],
      ),
      body: Column(
        children: [
          const CategoryFilterBar(),
          Expanded(
            child: productsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text('$error'),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () =>
                          ref.invalidate(filteredProductsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (products) => GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    onTap: () => context.pushNamed(
                      AppRoutes.productDetailName,
                      pathParameters: {'id': product.id.toString()},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresshi/core/utils/string_extensions.dart';
import 'package:fresshi/shared/ui/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:fresshi/routes/app_routes.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/features/products/presentation/providers/products_provider.dart';
import 'package:fresshi/features/cart/presentation/providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Cart',
            onPressed: () => context.pushNamed(AppRoutes.cartName),
          ),
        ],
      ),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (products) {
          final product = products.cast<Product?>().firstWhere(
            (p) => p?.id == productId,
            orElse: () => null,
          );

          if (product == null) {
            return const Center(child: Text('Product not found'));
          }

          return _ProductDetailBody(product: product);
        },
      ),
    );
  }
}

class _ProductDetailBody extends ConsumerWidget {
  final Product product;

  const _ProductDetailBody({required this.product});

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case "men's clothing":
        return const Color(0xFF1565C0);
      case "women's clothing":
        return const Color(0xFFC2185B);
      case 'jewelery':
        return const Color(0xFFEF6C00);
      case 'electronics':
        return const Color(0xFF2E7D32);
      default:
        return AppColors.secondary;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final categoryColor = _categoryColor(product.category);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Semantics(
              label: product.title,
              child: Image.network(
                product.image,
                height: 280,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 80),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Chip(
                label: Text(
                  product.category.capitalize,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: categoryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: categoryColor.withValues(alpha: 0.14),
                side: BorderSide(
                  color: categoryColor.withValues(alpha: 0.35),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              Text(
                '${product.ratingRate} (${product.ratingCount} reviews)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(product.title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),

          const SizedBox(height: 16),
          Text(
            'ABOUT PRODUCT',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(product.description, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ref.read(cartProvider.notifier).addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} added to cart'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}

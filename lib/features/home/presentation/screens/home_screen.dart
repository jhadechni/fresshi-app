import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fresshi/routes/app_routes.dart';
import 'package:fresshi/features/products/presentation/providers/products_provider.dart';
import 'package:fresshi/features/products/presentation/widgets/product_card.dart';
import 'package:fresshi/features/cart/presentation/providers/cart_provider.dart';
import 'package:fresshi/shared/ui/theme/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    final cartCount = ref.watch(
      cartProvider.select((items) => items.fold(0, (s, i) => s + i.quantity)),
    );
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fresshi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => context.pushNamed(AppRoutes.searchName),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                tooltip: 'Cart',
                onPressed: () => context.pushNamed(AppRoutes.cartName),
              ),
              if (cartCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: theme.colorScheme.error,
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _HeroBanner(onShopNow: () => context.pushNamed(AppRoutes.productListName)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trending Now',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => context.pushNamed(AppRoutes.productListName),
                    child: const Text('View all'),
                  ),
                ],
              ),
            ),
          ),
          productsAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(child: Text('$error')),
            ),
            data: (products) {
              final featured = products.take(6).toList();
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ProductCard(
                      product: featured[index],
                      onTap: () => context.pushNamed(
                        AppRoutes.productDetailName,
                        pathParameters: {'id': featured[index].id.toString()},
                      ),
                    ),
                    childCount: featured.length,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final VoidCallback onShopNow;

  const _HeroBanner({required this.onShopNow});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // Deep Navy → Electric Blue horizontal gradient
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.primary, AppColors.accent],
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Fresshi',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Discover amazing products',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textOnPrimary.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: onShopNow,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.textOnPrimary,
                foregroundColor: AppColors.primary,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text('Shop Now'),
            ),
          ],
        ),
      ),
    );
  }
}

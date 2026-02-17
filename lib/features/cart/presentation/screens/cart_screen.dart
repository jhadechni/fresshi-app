import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresshi/features/cart/presentation/providers/cart_provider.dart';
import 'package:fresshi/features/cart/presentation/widgets/cart_item_tile.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: notifier.clear,
              child: const Text('Clear all'),
            ),
        ],
      ),
      body: items.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64),
                  SizedBox(height: 16),
                  Text('Your cart is empty'),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) =>
                  CartItemTile(item: items[index]),
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: theme.textTheme.titleMedium),
                        Text(
                          '\$${notifier.totalPrice.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          notifier.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed successfully!'),
                            ),
                          );
                        },
                        child: const Text('Checkout'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

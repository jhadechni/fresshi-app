import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresshi/features/cart/domain/entities/cart_item.dart';
import 'package:fresshi/features/cart/presentation/providers/cart_provider.dart';

class CartItemTile extends ConsumerWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartProvider.notifier);
    final theme = Theme.of(context);

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.product.image,
            width: 64,
            height: 64,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 48),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                '\$${item.product.price.toStringAsFixed(2)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              tooltip: 'Decrease quantity',
              onPressed: () => notifier.updateQuantity(
                item.product.id,
                item.quantity - 1,
              ),
            ),
            Text('${item.quantity}', style: theme.textTheme.titleSmall),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              tooltip: 'Increase quantity',
              onPressed: () => notifier.updateQuantity(
                item.product.id,
                item.quantity + 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

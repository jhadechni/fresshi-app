import 'package:flutter/material.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/shared/ui/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image — 16px top radius, fills available space
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Semantics(
                  label: product.title,
                  child: Container(
                    color: const Color(0xFFF8F9FA),
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.broken_image_outlined,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Product info
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_border_rounded,
                            size: 13,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            product.ratingRate.toStringAsFixed(1),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

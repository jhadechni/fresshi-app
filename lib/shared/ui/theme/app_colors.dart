import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary palette
  static const Color primary = Color(0xFF1A237E); // Deep Navy
  static const Color secondary = Color(0xFF455A64); // Slate Gray
  static const Color accent = Color(0xFF2979FF); // Electric Blue

  // Backgrounds
  static const Color background = Color(0xFFF8F9FA); // Off-White
  static const Color surface = Color(0xFFFFFFFF); // Pure White (cards)
  static const Color surfaceDark = Color(0xFF121212);
  static const Color backgroundDark = Color(0xFF1E1E1E);

  // Text
  static const Color textPrimary = Color(0xFF212121); // Charcoal
  static const Color textSecondary = Color(0xFF757575); // Cool Gray
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Semantic
  static const Color inStock = accent; // Electric Blue for "In Stock"
  static const Color error = Color(0xFFD32F2F);
  static const Color divider = Color(0xFFE0E0E0);

  // Shadow
  /// 0px 4px 12px, 5% opacity black — "Soft UI" card shadow
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
}

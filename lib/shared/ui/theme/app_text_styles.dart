import 'package:flutter/material.dart';
import 'package:fresshi/shared/ui/theme/app_colors.dart';

abstract final class AppTextStyles {
  static const String _family = 'Inter';

  /// Heading — Bold 700, 24px, tight letter spacing
  static TextStyle get heading => const TextStyle(
        fontFamily: _family,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.48,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  /// Subheading — Bold 700, 20px
  static TextStyle get subheading => const TextStyle(
        fontFamily: _family,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  /// Product name — Semi-Bold 600, 16px
  static TextStyle get productName => const TextStyle(
        fontFamily: _family,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  /// Product name large — Semi-Bold 600, 18px (detail screen)
  static TextStyle get productNameLarge => const TextStyle(
        fontFamily: _family,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  /// Body — Regular 400, 14px, comfortable line height
  static TextStyle get body => const TextStyle(
        fontFamily: _family,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  /// Body secondary — Regular 400, 14px, muted color
  static TextStyle get bodySecondary => const TextStyle(
        fontFamily: _family,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  /// Caption / Spec — Medium 500, 12px
  static TextStyle get caption => const TextStyle(
        fontFamily: _family,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  /// Price — Bold 700, 16px, primary color
  static TextStyle get price => const TextStyle(
        fontFamily: _family,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        height: 1.2,
      );

  /// Button label — Semi-Bold 600, 14px
  static TextStyle get button => const TextStyle(
        fontFamily: _family,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.28,
        color: AppColors.textOnPrimary,
        height: 1.2,
      );
}

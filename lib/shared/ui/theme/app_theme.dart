import 'package:flutter/material.dart';
import 'package:fresshi/shared/ui/theme/app_colors.dart';

abstract final class AppTheme {
  static const String _font = 'Inter';

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: const Color(0xFF3949AB),
      onPrimaryContainer: AppColors.textOnPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnPrimary,
      secondaryContainer: const Color(0xFF607D8B),
      onSecondaryContainer: AppColors.textOnPrimary,
      tertiary: AppColors.accent,
      onTertiary: AppColors.textOnPrimary,
      tertiaryContainer: const Color(0xFF448AFF),
      onTertiaryContainer: AppColors.textOnPrimary,
      surface: isDark ? AppColors.surfaceDark : AppColors.surface,
      onSurface: isDark ? AppColors.textOnPrimary : AppColors.textPrimary,
      surfaceContainerHighest:
          isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF1F3F4),
      onSurfaceVariant: AppColors.textSecondary,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
      errorContainer: const Color(0xFFFFCDD2),
      onErrorContainer: AppColors.error,
      outline: isDark ? const Color(0xFF424242) : AppColors.divider,
      outlineVariant:
          isDark ? const Color(0xFF303030) : const Color(0xFFEEEEEE),
      surfaceDim: isDark ? AppColors.backgroundDark : AppColors.background,
    );

    final Color textMain =
        isDark ? AppColors.textOnPrimary : AppColors.textPrimary;
    final Color textMuted =
        isDark ? const Color(0xFFBDBDBD) : AppColors.textSecondary;

    final textTheme = TextTheme(
      displaySmall: TextStyle(
        fontFamily: _font,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.72,
        color: textMain,
        height: 1.1,
      ),
      headlineMedium: TextStyle(
        fontFamily: _font,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.48,
        color: textMain,
        height: 1.2,
      ),
      headlineSmall: TextStyle(
        fontFamily: _font,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: textMain,
        height: 1.2,
      ),
      titleLarge: TextStyle(
        fontFamily: _font,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textMain,
        height: 1.3,
      ),
      titleMedium: TextStyle(
        fontFamily: _font,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textMain,
        height: 1.3,
      ),
      titleSmall: TextStyle(
        fontFamily: _font,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textMain,
        height: 1.3,
      ),
      bodyLarge: TextStyle(
        fontFamily: _font,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textMain,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: _font,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textMuted,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: _font,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMuted,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontFamily: _font,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.28,
        color: textMain,
        height: 1.2,
      ),
      labelMedium: TextStyle(
        fontFamily: _font,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMuted,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontFamily: _font,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textMuted,
        height: 1.4,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      fontFamily: _font,
      scaffoldBackgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.background,
      textTheme: textTheme,

      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        foregroundColor:
            isDark ? AppColors.textOnPrimary : AppColors.textPrimary,
        titleTextStyle: TextStyle(
          fontFamily: _font,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.36,
          color: isDark ? AppColors.textOnPrimary : AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(
          color: isDark ? AppColors.textOnPrimary : AppColors.textPrimary,
          size: 24,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF424242) : AppColors.divider,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF424242) : AppColors.divider,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: isDark ? const Color(0xFF2C2C2C) : AppColors.surface,
        labelStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        hintStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          textStyle: const TextStyle(
            fontFamily: _font,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.28,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: const TextStyle(
            fontFamily: _font,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: const TextStyle(
            fontFamily: _font,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF1F3F4),
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          fontFamily: _font,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.textOnPrimary : AppColors.textPrimary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textOnPrimary,
        ),
        side: BorderSide(
          color: isDark ? const Color(0xFF424242) : AppColors.divider,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      iconTheme: IconThemeData(
        color: isDark ? AppColors.textOnPrimary : AppColors.textPrimary,
        size: 24,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textOnPrimary,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

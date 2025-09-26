import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

part 'app_theme.g.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.white,
      ),
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      dividerTheme: _dividerTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: Color(0xFF1E1E1E),
        background: Color(0xFF121212),
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
        onBackground: AppColors.white,
        onError: AppColors.white,
      ),
      textTheme: _textTheme.apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: AppColors.white,
      ),
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme.copyWith(color: const Color(0xFF2C2C2C)),
      bottomNavigationBarTheme: _bottomNavigationBarTheme.copyWith(
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      dividerTheme: _dividerTheme.copyWith(color: AppColors.greyDark),
    );
  }

  static TextTheme get _textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: AppFonts.hero,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.display,
        height: AppFonts.tight,
      ),
      displayMedium: TextStyle(
        fontSize: AppFonts.displaySize,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.display,
        height: AppFonts.tight,
      ),
      displaySmall: TextStyle(
        fontSize: AppFonts.xxxl,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.display,
        height: AppFonts.normal,
      ),
      headlineLarge: TextStyle(
        fontSize: AppFonts.xxxl,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
      headlineMedium: TextStyle(
        fontSize: AppFonts.xxl,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
      headlineSmall: TextStyle(
        fontSize: AppFonts.xl,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
      titleLarge: TextStyle(
        fontSize: AppFonts.lg,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
      titleMedium: TextStyle(
        fontSize: AppFonts.base,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
      titleSmall: TextStyle(
        fontSize: AppFonts.sm,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
      bodyLarge: TextStyle(
        fontSize: AppFonts.lg,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.primary,
        height: AppFonts.relaxed,
      ),
      bodyMedium: TextStyle(
        fontSize: AppFonts.base,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.primary,
        height: AppFonts.relaxed,
      ),
      bodySmall: TextStyle(
        fontSize: AppFonts.sm,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.primary,
        height: AppFonts.relaxed,
      ),
      labelLarge: TextStyle(
        fontSize: AppFonts.sm,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
      labelMedium: TextStyle(
        fontSize: AppFonts.xs,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
      labelSmall: TextStyle(
        fontSize: AppFonts.xs,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.primary,
        height: AppFonts.normal,
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: AppFonts.lg,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 2,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: AppFonts.base,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: AppFonts.base,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: TextStyle(
          fontSize: AppFonts.base,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: const TextStyle(
        color: AppColors.textHint,
        fontSize: AppFonts.base,
      ),
    );
  }

  static CardTheme get _cardTheme {
    return CardTheme(
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
    );
  }

  static BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    return const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }

  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    );
  }
}

@riverpod
class AppThemeNotifier extends _$AppThemeNotifier {
  @override
  bool build() {
    // Default to light theme
    return false;
  }

  void toggleTheme() {
    state = !state;
  }

  void setDarkMode(bool isDark) {
    state = isDark;
  }
}

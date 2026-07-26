import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // === Primary Palette ===
  static const Color primary = Color(0xFF22C55E);         // Vibrant green
  static const Color primaryDark = Color(0xFF16A34A);
  static const Color primaryLight = Color(0xFF4ADE80);

  // === Accent ===
  static const Color accent = Color(0xFFF59E0B);          // Saffron/amber
  static const Color accentLight = Color(0xFFFBBF24);

  // === Backgrounds ===
  static const Color background = Color(0xFF0A0E1A);      // Deep navy
  static const Color surface = Color(0xFF131929);         // Card surface
  static const Color surfaceLight = Color(0xFF1E2A3A);    // Lighter surface
  static const Color cardBg = Color(0xFF182233);

  // === Text ===
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // === Status ===
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // === Macros ===
  static const Color proteinColor = Color(0xFF3B82F6);    // Blue
  static const Color carbsColor = Color(0xFFF59E0B);      // Amber
  static const Color fatColor = Color(0xFFEC4899);        // Pink
  static const Color fiberColor = Color(0xFF8B5CF6);      // Purple

  // === Gradients ===
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF182233), Color(0xFF1E2A3A)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A0E1A), Color(0xFF131929)],
  );
}

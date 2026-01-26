import 'package:flutter/material.dart';

/// Application color palette.
///
/// Contains all colors used throughout the app.
/// Use these constants instead of hardcoding colors.
abstract class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2D3436);
  static const Color primaryLight = Color(0xFF636E72);
  static const Color primaryDark = Color(0xFF1E272E);

  // Accent colors
  static const Color accent = Color(0xFFE17055);
  static const Color accentLight = Color(0xFFFF9F7F);
  static const Color accentDark = Color(0xFFC45C45);

  // Background colors
  static const Color background = Color(0xFFF5F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F2F6);

  // Text colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textHint = Color(0xFFB2BEC3);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status colors
  static const Color success = Color(0xFF00B894);
  static const Color error = Color(0xFFD63031);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color info = Color(0xFF0984E3);

  // Border & divider
  static const Color border = Color(0xFFDFE6E9);
  static const Color divider = Color(0xFFE0E0E0);

  // Shadow
  static const Color shadow = Color(0x1A000000);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF2D2D2D);
  static const Color darkSurfaceVariant = Color(0xFF3D3D3D);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
}

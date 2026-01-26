import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Text style variants for [AppText].
enum AppTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
  price,
  priceStrikethrough,
}

/// A text widget that follows the app's typography system.
///
/// Features:
/// - Multiple text variants based on Material Design 3
/// - Custom color support
/// - Text alignment options
/// - Max lines and overflow handling
///
/// Usage:
/// ```dart
/// AppText(
///   text: 'Welcome to FurniShop',
///   variant: AppTextVariant.headlineLarge,
/// )
/// ```
class AppText extends StatelessWidget {
  /// The text to display.
  final String text;

  /// Text style variant.
  final AppTextVariant variant;

  /// Custom text color (overrides variant color).
  final Color? color;

  /// Text alignment.
  final TextAlign? textAlign;

  /// Maximum number of lines.
  final int? maxLines;

  /// Text overflow behavior.
  final TextOverflow? overflow;

  /// Font weight override.
  final FontWeight? fontWeight;

  /// Custom font size override.
  final double? fontSize;

  /// Custom letter spacing.
  final double? letterSpacing;

  /// Text decoration.
  final TextDecoration? decoration;

  const AppText({
    super.key,
    required this.text,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.decoration,
  });

  /// Factory constructor for displaying prices.
  factory AppText.price({
    Key? key,
    required double amount,
    String currency = '\$',
    Color? color,
  }) {
    return AppText(
      key: key,
      text: '$currency${amount.toStringAsFixed(2)}',
      variant: AppTextVariant.price,
      color: color,
    );
  }

  /// Factory constructor for strikethrough prices (original price).
  factory AppText.originalPrice({
    Key? key,
    required double amount,
    String currency = '\$',
  }) {
    return AppText(
      key: key,
      text: '$currency${amount.toStringAsFixed(2)}',
      variant: AppTextVariant.priceStrikethrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
    );
  }

  TextStyle _getStyle() {
    TextStyle baseStyle = _getBaseStyle();

    return baseStyle.copyWith(
      color: color ?? baseStyle.color,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      fontSize: fontSize ?? baseStyle.fontSize,
      letterSpacing: letterSpacing ?? baseStyle.letterSpacing,
      decoration: decoration ?? baseStyle.decoration,
    );
  }

  TextStyle _getBaseStyle() {
    switch (variant) {
      case AppTextVariant.displayLarge:
        return AppTypography.displayLarge;
      case AppTextVariant.displayMedium:
        return AppTypography.displayMedium;
      case AppTextVariant.displaySmall:
        return AppTypography.displaySmall;
      case AppTextVariant.headlineLarge:
        return AppTypography.headlineLarge;
      case AppTextVariant.headlineMedium:
        return AppTypography.headlineMedium;
      case AppTextVariant.headlineSmall:
        return AppTypography.headlineSmall;
      case AppTextVariant.titleLarge:
        return AppTypography.titleLarge;
      case AppTextVariant.titleMedium:
        return AppTypography.titleMedium;
      case AppTextVariant.titleSmall:
        return AppTypography.titleSmall;
      case AppTextVariant.bodyLarge:
        return AppTypography.bodyLarge;
      case AppTextVariant.bodyMedium:
        return AppTypography.bodyMedium;
      case AppTextVariant.bodySmall:
        return AppTypography.bodySmall;
      case AppTextVariant.labelLarge:
        return AppTypography.labelLarge;
      case AppTextVariant.labelMedium:
        return AppTypography.labelMedium;
      case AppTextVariant.labelSmall:
        return AppTypography.labelSmall;
      case AppTextVariant.price:
        return AppTypography.priceRegular;
      case AppTextVariant.priceStrikethrough:
        return AppTypography.priceStrikethrough;
    }
  }
}

/// Convenience class for common text widgets.
///
/// Usage:
/// ```dart
/// AppTextStyles.heading('Title')
/// AppTextStyles.body('Description')
/// ```
class AppTextStyles {
  AppTextStyles._();

  static Widget heading(String text, {Color? color}) => AppText(
        text: text,
        variant: AppTextVariant.headlineMedium,
        color: color,
      );

  static Widget subheading(String text, {Color? color}) => AppText(
        text: text,
        variant: AppTextVariant.titleMedium,
        color: color,
      );

  static Widget body(String text, {Color? color, int? maxLines}) => AppText(
        text: text,
        variant: AppTextVariant.bodyMedium,
        color: color,
        maxLines: maxLines,
      );

  static Widget caption(String text, {Color? color}) => AppText(
        text: text,
        variant: AppTextVariant.bodySmall,
        color: color ?? AppColors.textSecondary,
      );

  static Widget label(String text, {Color? color}) => AppText(
        text: text,
        variant: AppTextVariant.labelMedium,
        color: color,
      );
}

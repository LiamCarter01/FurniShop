import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Button variant types for [AppButton].
enum AppButtonVariant {
  /// Filled button with primary color background.
  primary,

  /// Filled button with accent color background.
  accent,

  /// Outlined button with border.
  outlined,

  /// Text-only button without background.
  text,
}

/// Button size options for [AppButton].
enum AppButtonSize {
  small,
  medium,
  large,
}

/// A customizable button component following app design system.
///
/// Features:
/// - Multiple variants (primary, accent, outlined, text)
/// - Multiple sizes (small, medium, large)
/// - Loading state support
/// - Icon support (leading and trailing)
/// - Full width option
///
/// Usage:
/// ```dart
/// AppButton(
///   label: 'Add to Cart',
///   onPressed: () => addToCart(),
///   variant: AppButtonVariant.accent,
///   leadingIcon: Icons.shopping_cart,
/// )
/// ```
class AppButton extends StatelessWidget {
  /// The button label text.
  final String label;

  /// Callback when button is pressed.
  final VoidCallback? onPressed;

  /// Button style variant.
  final AppButtonVariant variant;

  /// Button size.
  final AppButtonSize size;

  /// Optional leading icon.
  final IconData? leadingIcon;

  /// Optional trailing icon.
  final IconData? trailingIcon;

  /// Whether the button should take full width.
  final bool fullWidth;

  /// Whether the button is in loading state.
  final bool isLoading;

  /// Whether the button is disabled.
  final bool isDisabled;

  /// Custom border radius.
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled || isLoading || onPressed == null;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: _getHeight(),
      child: _buildButton(context, disabled),
    );
  }

  Widget _buildButton(BuildContext context, bool disabled) {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: _getPrimaryStyle(),
          child: _buildChild(),
        );
      case AppButtonVariant.accent:
        return ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: _getAccentStyle(),
          child: _buildChild(),
        );
      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: disabled ? null : onPressed,
          style: _getOutlinedStyle(),
          child: _buildChild(),
        );
      case AppButtonVariant.text:
        return TextButton(
          onPressed: disabled ? null : onPressed,
          style: _getTextStyle(),
          child: _buildChild(),
        );
    }
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == AppButtonVariant.outlined ||
                    variant == AppButtonVariant.text
                ? AppColors.primary
                : AppColors.textOnPrimary,
          ),
        ),
      );
    }

    final List<Widget> children = [];

    if (leadingIcon != null) {
      children.add(Icon(leadingIcon, size: _getIconSize()));
      children.add(SizedBox(width: _getSpacing()));
    }

    children.add(
      Text(
        label,
        style: _getTextStyle2(),
      ),
    );

    if (trailingIcon != null) {
      children.add(SizedBox(width: _getSpacing()));
      children.add(Icon(trailingIcon, size: _getIconSize()));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  double _getSpacing() {
    switch (size) {
      case AppButtonSize.small:
        return 4;
      case AppButtonSize.medium:
        return 8;
      case AppButtonSize.large:
        return 12;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 28);
    }
  }

  TextStyle _getTextStyle2() {
    switch (size) {
      case AppButtonSize.small:
        return AppTypography.labelMedium;
      case AppButtonSize.medium:
        return AppTypography.button;
      case AppButtonSize.large:
        return AppTypography.button.copyWith(fontSize: 16);
    }
  }

  double _getBorderRadius() => borderRadius ?? 8;

  ButtonStyle _getPrimaryStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_getBorderRadius()),
      ),
    );
  }

  ButtonStyle _getAccentStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.textOnPrimary,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_getBorderRadius()),
      ),
    );
  }

  ButtonStyle _getOutlinedStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: _getPadding(),
      side: const BorderSide(color: AppColors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_getBorderRadius()),
      ),
    );
  }

  ButtonStyle _getTextStyle() {
    return TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_getBorderRadius()),
      ),
    );
  }
}

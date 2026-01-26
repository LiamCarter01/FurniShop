import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A scaffold wrapper that provides consistent app structure.
///
/// Features:
/// - Consistent app bar styling
/// - Optional floating action button
/// - Optional bottom navigation
/// - Background color from theme
///
/// Usage:
/// ```dart
/// AppScaffold(
///   title: 'Products',
///   body: ProductList(),
/// )
/// ```
class AppScaffold extends StatelessWidget {
  /// The title displayed in the app bar.
  final String? title;

  /// Custom title widget (overrides [title] if provided).
  final Widget? titleWidget;

  /// The main content of the scaffold.
  final Widget body;

  /// Optional floating action button.
  final Widget? floatingActionButton;

  /// Optional bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// Optional drawer.
  final Widget? drawer;

  /// Whether to show the app bar.
  final bool showAppBar;

  /// Custom leading widget for app bar.
  final Widget? leading;

  /// Custom actions for app bar.
  final List<Widget>? actions;

  /// Whether to show back button automatically.
  final bool automaticallyImplyLeading;

  /// Background color for the scaffold.
  final Color? backgroundColor;

  /// App bar background color.
  final Color? appBarBackgroundColor;

  /// Whether app bar should be transparent.
  final bool transparentAppBar;

  /// Floating action button location.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppScaffold({
    super.key,
    this.title,
    this.titleWidget,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.showAppBar = true,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.transparentAppBar = false,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: transparentAppBar
          ? Colors.transparent
          : (appBarBackgroundColor ?? AppColors.surface),
      elevation: transparentAppBar ? 0 : null,
    );
  }
}

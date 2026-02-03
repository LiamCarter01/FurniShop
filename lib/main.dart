import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navigation/routes.dart';
import 'core/theme/app_theme.dart';

/// Main entry point for the FurniShop application.
///
void main() {
  runApp(
    const ProviderScope(
      child: FurniShopApp(),
    ),
  );
}

/// Root widget for the FurniShop application.
///
/// Configures:
/// - Material theme using [AppTheme]
/// - Navigation using [AppRouter]
class FurniShopApp extends ConsumerWidget {
  const FurniShopApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'FurniShop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

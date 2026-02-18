import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/chairs/presentation/pages/chair_detail_page.dart';
import '../../features/chairs/presentation/pages/chairs_page.dart';
import '../../features/desks/presentation/pages/desk_detail_page.dart';
import '../../features/desks/presentation/pages/desks_page.dart';
import '../../features/bedrooms/presentation/pages/bedroom_detail_page.dart';
import '../../features/bedrooms/presentation/pages/bedrooms_page.dart';
import '../../features/living_rooms/presentation/pages/living_rooms_page.dart';
import '../../features/living_rooms/presentation/pages/living_room_detail_page.dart';
import 'home_page.dart';

/// Application route paths.
///
/// Use these constants for navigation instead of hardcoding paths.
abstract class AppRoutes {
  static const String home = '/';
  static const String chairs = '/chairs';
  static const String chairDetail = '/chairs/:id';
  static const String desks = '/desks';
  static const String deskDetail = '/desks/:id';
  static const String bedrooms = '/bedrooms';
  static const String bedroomDetail = '/bedrooms/:id';
  static const String livingRooms = '/living_rooms';
  static const String livingRoomDetail = '/living_rooms/:id';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String search = '/search';

  /// Generate chair detail path with ID.
  static String chairDetailPath(String id) => '/chairs/$id';

  /// Generate desk detail path with ID.
  static String deskDetailPath(String id) => '/desks/$id';

  /// Generate bedroom detail path with ID.
  static String bedroomDetailPath(String id) => '/bedrooms/$id';

  /// Generate living room detail path with ID.
  static String livingRoomDetailPath(String id) => '/living_rooms/$id';
}

/// Router provider for GoRouter.
///
/// Use this to access the router instance.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      // Home route
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // Chairs routes
      GoRoute(
        path: AppRoutes.chairs,
        name: 'chairs',
        builder: (context, state) => const ChairsPage(),
        routes: [
          GoRoute(
            path: ':id',
            name: 'chair-detail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ChairDetailPage(chairId: id);
            },
          ),
        ],
      ),

      // Desks routes
      GoRoute(
        path: AppRoutes.desks,
        name: 'desks',
        builder: (context, state) => const DesksPage(),
        routes: [
          GoRoute(
            path: ':id',
            name: 'desk-detail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return DeskDetailPage(deskId: id);
            },
          ),
        ],
      ),

      // Bedrooms routes
      GoRoute(
        path: AppRoutes.bedrooms,
        name: 'bedrooms',
        builder: (context, state) => const BedroomsPage(),
        routes: [
          GoRoute(
            path: ':id',
            name: 'bedroom-detail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return BedroomDetailPage(bedroomId: id);
            },
          ),
        ],
      ),

      // Living rooms routes
      GoRoute(
        path: AppRoutes.livingRooms,
        name: 'living-rooms',
        builder: (context, state) => const LivingRoomsPage(),
        routes: [
          GoRoute(
            path: ':id',
            name: 'living-room-detail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return LivingRoomDetailPage(livingRoomId: id);
            },
          ),
        ],
      ),
      // Cart route (placeholder)
      GoRoute(
        path: AppRoutes.cart,
        name: 'cart',
        builder: (context, state) => const _PlaceholderPage(title: 'Cart'),
      ),

      // Profile route (placeholder)
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => const _PlaceholderPage(title: 'Profile'),
      ),
    ],
    errorBuilder: (context, state) => _ErrorPage(error: state.error),
  );
});

/// Placeholder page for unimplemented features.
///
/// Replace this with actual feature pages.
class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              '$title - Coming Soon',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'This feature is under development.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Error page for navigation errors.
class _ErrorPage extends StatelessWidget {
  final Exception? error;

  const _ErrorPage({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            if (error != null)
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
